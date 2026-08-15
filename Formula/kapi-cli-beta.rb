class KapiCliBeta < Formula
  desc "Format-aware content engine — parse, edit and check any format"
  homepage "https://github.com/neokapi/neokapi"
  version "1.2.0-rc24"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-pdfium"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc24/kapi-cli_1.2.0-rc24_darwin_arm64.tar.gz"
      sha256 "ff0d200028f5ed065d2878d304481f41aa56cbde3a9c42e76f1baf440879caf9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc24/kapi-cli_1.2.0-rc24_linux_arm64.tar.gz"
      sha256 "d54b352839a144a3adae6f7efd21e08c11c20e199e54250a9c2cbde641c641dd"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc24/kapi-cli_1.2.0-rc24_linux_amd64.tar.gz"
      sha256 "22bd56a069a4d04dc1d6b7e98df719449b852cdce41a0fbb71d3f240ec48aa64"
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
