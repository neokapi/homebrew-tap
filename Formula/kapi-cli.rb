require "#{Tap.fetch("neokapi", "tap").path}/lib/private_download_strategy"

class KapiCli < Formula
  desc "AI-native localization framework — format-aware parsing, concurrent pipelines, and pluggable tools"
  homepage "https://github.com/neokapi/neokapi"
  version "1.2.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0/kapi_1.2.0_darwin_arm64.tar.gz", using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "eb05c4fce82239a2375e77b46df6a189c09f430e8d0c18a96556dd4b47e5a483"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0/kapi_1.2.0_linux_arm64.tar.gz", using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "1da4a490f2a1e4cf791aca25b9976b940e13ce8b6a00f2f0f078c9f92d0c1a71"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0/kapi_1.2.0_linux_amd64.tar.gz", using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "43f0e372d86d691599251b986ebdb830a96667a6c2c92aec67c194865d404db8"
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
