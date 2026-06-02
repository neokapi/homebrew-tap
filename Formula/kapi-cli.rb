require "#{Tap.fetch("neokapi", "tap").path}/lib/private_download_strategy"

class KapiCli < Formula
  desc "AI-native localization framework — format-aware parsing, concurrent pipelines, and pluggable tools"
  homepage "https://github.com/neokapi/neokapi"
  version "1.1.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.1.1/kapi_1.1.1_darwin_arm64.tar.gz", using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "7134bd6ac26ee9c5b15c56a21e6be91e6654217fcc05107ff1523b3f6e61a092"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.1.1/kapi_1.1.1_linux_arm64.tar.gz", using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "2a8d74fcc3c69931b1e2d9a57a2232825f6054bbc78920a206cee1d3dabe8f17"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.1.1/kapi_1.1.1_linux_amd64.tar.gz", using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "fc1b4bc09c94aaea453318feaf92b7a3477b0d7c2064fe873a2a1e4517eb97af"
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
