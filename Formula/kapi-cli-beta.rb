class KapiCliBeta < Formula
  desc "AI-native localization framework — format-aware parsing and pluggable tools"
  homepage "https://github.com/neokapi/neokapi"
  version "1.2.0-rc18"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-pdfium"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc18/kapi-cli_1.2.0-rc18_darwin_arm64.tar.gz"
      sha256 "37150ac02badbeecf7836de9a1b4a2f85e0529ca9249d280b2e35a9b21b6d684"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc18/kapi-cli_1.2.0-rc18_linux_arm64.tar.gz"
      sha256 "02d10856f09cf021d0b5991c8e1270ac0e77553812a7a18bee7c8db343fb7b5f"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc18/kapi-cli_1.2.0-rc18_linux_amd64.tar.gz"
      sha256 "b76858973a4cb04710d18532034bcfb5a6ef26b3270de577ec9b4522ea1380b9"
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
