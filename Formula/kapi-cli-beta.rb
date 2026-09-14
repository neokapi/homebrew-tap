class KapiCliBeta < Formula
  desc "Format-aware content engine — parse, edit and check any format"
  homepage "https://github.com/neokapi/neokapi"
  version "1.2.0-rc31"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-pdfium"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc31/kapi-cli_1.2.0-rc31_darwin_arm64.tar.gz"
      sha256 "b0e5ce30231c85569f9857626cecbc427ebbce82411af3a730a885680d4ca9ce"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc31/kapi-cli_1.2.0-rc31_linux_arm64.tar.gz"
      sha256 "35933d53bdf952fa5b529e718b98f97044a3457b64ae7e54f2d3a1bdc6f203f1"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc31/kapi-cli_1.2.0-rc31_linux_amd64.tar.gz"
      sha256 "8c6bd10ff20801e001b3153728f038afd547184f14946fad61a2ef1fa0cfb7a9"
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
