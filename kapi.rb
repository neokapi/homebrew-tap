require_relative "lib/private_download_strategy"

class Kapi < Formula
  desc "AI-native localization framework — format-aware parsing, concurrent pipelines, and pluggable tools"
  homepage "https://github.com/gokapi/gokapi"
  version "0.1.2"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/gokapi/gokapi/releases/download/v0.1.2/kapi_0.1.2_darwin_amd64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "dfb1e0a8b4d498e7d2a146c4d09d753adca5afd4a18b899900018d252d33de9b"
    end
    if Hardware::CPU.arm?
      url "https://github.com/gokapi/gokapi/releases/download/v0.1.2/kapi_0.1.2_darwin_arm64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "e76ea50a5a3034bc371a6d641c17fd181af51da0fd6078b1eb3e2f0868751bb5"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/gokapi/gokapi/releases/download/v0.1.2/kapi_0.1.2_linux_amd64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "dc0d8554954c75d68aa5d4a1899d3b65a4dab7f6e38765f149cd2c5812dcf1ed"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/gokapi/gokapi/releases/download/v0.1.2/kapi_0.1.2_linux_arm64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "b33449b0d79e0021ca9744b4df465dfedfa3435254a1fc68f503e2be3750f6e1"
    end
  end

  def install
    bin.install "kapi"
  end

  test do
    system "#{bin}/kapi", "version"
  end
end
