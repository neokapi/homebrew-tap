require "#{Tap.fetch("neokapi", "tap").path}/lib/private_download_strategy"

class KapiCli < Formula
  desc "AI-native localization framework — format-aware parsing, concurrent pipelines, and pluggable tools"
  homepage "https://github.com/neokapi/neokapi"
  version "1.1.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.1.0/kapi_1.1.0_darwin_arm64.tar.gz", using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "88d6f41a7739b3392d4196ba8ef61402e14ca4b0418955f8980ade7fa146978e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.1.0/kapi_1.1.0_linux_arm64.tar.gz", using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "a95e3bf5b96f4652d6d4be092830e67d965421988a843a28679241048aa4e306"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.1.0/kapi_1.1.0_linux_amd64.tar.gz", using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "ddd5325d515a2bb6f01f3b41fc5f4cd8eb1b2def9b7fb6f7495f5f3b0060b20a"
    end
  end

  # Install kapi plus its multi-call toolbox aliases. kgrep / ksed / kcat are
  # symlinks to the kapi binary, which dispatches on its invocation name
  # (busybox-style) — no extra binaries, no extra download size.
  def install
    bin.install "kapi"
    bin.install_symlink bin/"kapi" => "kgrep"
    bin.install_symlink bin/"kapi" => "ksed"
    bin.install_symlink bin/"kapi" => "kcat"
  end

  test do
    system "#{bin}/kapi", "version"
    assert_match "grep", shell_output("#{bin}/kgrep --help 2>&1")
  end
end
