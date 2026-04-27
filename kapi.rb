# typed: false
# frozen_string_literal: true

# This file is overwritten by GoReleaser on each release. Do not edit
# manually except for placeholder values before the first release.
require_relative "lib/private_download_strategy"
class Kapi < Formula
  desc "AI-native localization framework — format-aware parsing, concurrent pipelines, and pluggable tools"
  homepage "https://github.com/neokapi/neokapi"
  version "0.2.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/neokapi/neokapi/releases/download/v0.2.0/kapi_0.2.0_darwin_amd64.tar.gz", using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "e475859be26ca33daaf6fe17f25296917df424aa1fb57c33cb38b6c6a7785186"

      define_method(:install) do
        bin.install "kapi"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/neokapi/neokapi/releases/download/v0.2.0/kapi_0.2.0_darwin_arm64.tar.gz", using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "a0f1132b93b2e0535697c450666cafe548a5a8fe772eafd65eddc4d26f8bd434"

      define_method(:install) do
        bin.install "kapi"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/neokapi/neokapi/releases/download/v0.2.0/kapi_0.2.0_linux_amd64.tar.gz", using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "3badb4c7bc0ac32c8a87b6c69ea67401687f7704fa260ba5998555d8dfd0f782"
      define_method(:install) do
        bin.install "kapi"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/neokapi/neokapi/releases/download/v0.2.0/kapi_0.2.0_linux_arm64.tar.gz", using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "c41e1dacf43d09ea9298c96310f00719834b6098421a1ce7377b3022b0215e87"
      define_method(:install) do
        bin.install "kapi"
      end
    end
  end

  test do
    system "#{bin}/kapi", "version"
  end
end
