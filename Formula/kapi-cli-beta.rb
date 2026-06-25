class KapiCliBeta < Formula
  desc "AI-native localization framework — format-aware parsing, concurrent pipelines, and pluggable tools"
  homepage "https://github.com/neokapi/neokapi"
  version "1.2.0-rc8"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-pdfium"
  conflicts_with "kapi-cli", because: "both install the kapi binary"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc8/kapi-cli_1.2.0-rc8_darwin_arm64.tar.gz"
      sha256 "c9bcce2baea4cc27bc130ebbc57120ab29a04e8083df80c5af283b05ba572767"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc8/kapi-cli_1.2.0-rc8_linux_arm64.tar.gz"
      sha256 "1c9215d7c3ecb00cd1b88d84ac5c95b77f3b8992b7e08ea559f23653af078297"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc8/kapi-cli_1.2.0-rc8_linux_amd64.tar.gz"
      sha256 "871e99f37654dd281a5d62ae4f511a3a9735e53d334daa6412d7a6b0f2fabc27"
    end
  end

  # Install kapi plus its multi-call toolbox aliases. kgrep / ksed / kcat / kconv
  # are symlinks to the kapi binary, which dispatches on its invocation name
  # (busybox-style) — no extra binaries, no extra download size.
  def install
    bin.install "kapi"
    bin.install_symlink bin/"kapi" => "kgrep"
    bin.install_symlink bin/"kapi" => "ksed"
    bin.install_symlink bin/"kapi" => "kcat"
    bin.install_symlink bin/"kapi" => "kconv"
  end

  test do
    system "#{bin}/kapi", "version"
    assert_match "grep", shell_output("#{bin}/kgrep --help 2>&1")
  end
end
