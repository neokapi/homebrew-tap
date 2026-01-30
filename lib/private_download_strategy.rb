require "download_strategy"

# Custom download strategy for fetching release assets from private GitHub repos.
# Translates a standard GitHub release URL into an authenticated API download.
#
# Requires HOMEBREW_GITHUB_API_TOKEN to be set in the environment.
#
# Usage in a formula:
#   require_relative "../lib/private_download_strategy"
#   class MyFormula < Formula
#     url "https://github.com/owner/repo/releases/download/vX.Y.Z/file.tar.gz",
#         using: GitHubPrivateRepositoryReleaseDownloadStrategy
#   end
class GitHubPrivateRepositoryDownloadStrategy < CurlDownloadStrategy
  require "utils/formatter"
  require "utils/github"

  def initialize(url, name, version, **meta)
    super
    parse_url_pattern
    set_github_token
  end

  def parse_url_pattern
    unless match = url.match(%r{https://github.com/([^/]+)/([^/]+)/(\S+)})
      raise CurlDownloadStrategyError, "Invalid url pattern for GitHub Repository."
    end
    _, @owner, @repo, @filepath = *match
  end

  private

  def _fetch(url:, resolved_url:, timeout:)
    curl_download(download_url, to: temporary_path)
  end

  def download_url
    "https://#{@github_token}@github.com/#{@owner}/#{@repo}/#{@filepath}"
  end

  def set_github_token
    @github_token = ENV["HOMEBREW_GITHUB_API_TOKEN"]
    unless @github_token
      raise CurlDownloadStrategyError,
            "HOMEBREW_GITHUB_API_TOKEN is required. Set it with: " \
            "export HOMEBREW_GITHUB_API_TOKEN=ghp_your_token"
    end
  end
end

class GitHubPrivateRepositoryReleaseDownloadStrategy < GitHubPrivateRepositoryDownloadStrategy
  def parse_url_pattern
    url_pattern = %r{https://github.com/([^/]+)/([^/]+)/releases/download/([^/]+)/(\S+)}
    unless match = url.match(url_pattern)
      raise CurlDownloadStrategyError, "Invalid url pattern for GitHub Release."
    end
    _, @owner, @repo, @tag, @filename = *match
  end

  def download_url
    "https://api.github.com/repos/#{@owner}/#{@repo}/releases/assets/#{asset_id}"
  end

  private

  def _fetch(url:, resolved_url:, timeout:)
    curl_download(
      download_url,
      "--header", "Accept: application/octet-stream",
      "--header", "Authorization: token #{@github_token}",
      to: temporary_path,
    )
  end

  def asset_id
    @asset_id ||= resolve_asset_id
  end

  def resolve_asset_id
    release_metadata = fetch_release_metadata
    assets = release_metadata["assets"].select { |a| a["name"] == @filename }
    raise CurlDownloadStrategyError, "Asset #{@filename} not found in release #{@tag}." if assets.empty?

    assets.first["id"]
  end

  def fetch_release_metadata
    release_url = "https://api.github.com/repos/#{@owner}/#{@repo}/releases/tags/#{@tag}"
    GitHub::API.open_rest(release_url)
  end
end
