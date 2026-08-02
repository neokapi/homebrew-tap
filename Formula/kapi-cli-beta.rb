class KapiCliBeta < Formula
  desc "AI-native localization framework — format-aware parsing and pluggable tools"
  homepage "https://github.com/neokapi/neokapi"
  version "1.2.0-rc16"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-pdfium"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc16/kapi-cli_1.2.0-rc16_darwin_arm64.tar.gz"
      sha256 "e27e95aadf0f276946a8f1d1bf97025a21b70bb312025dee8a05cfb2f7a31693"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc16/kapi-cli_1.2.0-rc16_linux_arm64.tar.gz"
      sha256 "c0d7a40e4eaf949eb4915551ab7e164bd6eb11fba7f5f04b2372672b075479d8"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc16/kapi-cli_1.2.0-rc16_linux_amd64.tar.gz"
      sha256 "62898d23c90c0fe9a252a200a3c481e6cdcdb20bbffdb181dae3c3447b679982"
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
