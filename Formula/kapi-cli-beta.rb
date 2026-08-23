class KapiCliBeta < Formula
  desc "Format-aware content engine — parse, edit and check any format"
  homepage "https://github.com/neokapi/neokapi"
  version "1.2.0-rc27"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-pdfium"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc27/kapi-cli_1.2.0-rc27_darwin_arm64.tar.gz"
      sha256 "5b714dfd702c03119950d178c12fe62027c6d65414422ca145cd8a41f8cbc48c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc27/kapi-cli_1.2.0-rc27_linux_arm64.tar.gz"
      sha256 "cba2f3731240b91db2d262f5cf1b1f80190cee2208ca12d21a532e86d1279a06"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc27/kapi-cli_1.2.0-rc27_linux_amd64.tar.gz"
      sha256 "7b32b4a8469bb68e8cf60294bd6cf4adb9af69ca5f4dab99b0e7fcc8bf040655"
    end
  end

  conflicts_with "kapi-cli", because: "both install the kapi binary"

  # Install kapi plus its multi-call toolbox aliases. kgrep / ksed / kcat /
  # kconv / kdiff are symlinks to the kapi binary, which dispatches on its
  # invocation name (busybox-style) — no extra binaries, no extra download size.
  def install
    bin.install "kapi"
    bin.install_symlink bin/"kapi" => "kgrep"
    bin.install_symlink bin/"kapi" => "ksed"
    bin.install_symlink bin/"kapi" => "kcat"
    bin.install_symlink bin/"kapi" => "kconv"
    bin.install_symlink bin/"kapi" => "kdiff"
  end

  # First exec of a newly installed binary pays macOS Gatekeeper's one-time
  # assessment (an XProtect scan proportional to binary size plus an online
  # notarization lookup — 1-3s for kapi). Absorb it at install time so the
  # user's first `kapi` command starts fast. `--version` exits before touching
  # any user config or project state; elsewhere this is a harmless ~20ms no-op.
  def post_install
    system bin/"kapi", "--version"
  end

  test do
    system "#{bin}/kapi", "version"
    assert_match "grep", shell_output("#{bin}/kgrep --help 2>&1")
    assert_match "diff", shell_output("#{bin}/kdiff --help 2>&1")
  end
end
