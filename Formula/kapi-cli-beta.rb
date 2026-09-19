class KapiCliBeta < Formula
  desc "AI-native localization framework — format-aware parsing and pluggable tools"
  homepage "https://github.com/neokapi/neokapi"
  version "1.2.0"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-pdfium"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0/kapi-cli_1.2.0_darwin_arm64.tar.gz"
      sha256 "d44f5ee94cc35079e03e550eaadab4e2c42931e832dc387cf2619a34f106e5a8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0/kapi-cli_1.2.0_linux_arm64.tar.gz"
      sha256 "a93dec5e38673b68bcd6c3f920fa918b68fa9ab508cdc9946215755fa97b0325"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0/kapi-cli_1.2.0_linux_amd64.tar.gz"
      sha256 "ed6ee0de09be4f2a3d98e2d2ad3de149592edc765a9ba8a6d08cf5d3291e123e"
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
