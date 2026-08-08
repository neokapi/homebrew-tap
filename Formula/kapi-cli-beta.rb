class KapiCliBeta < Formula
  desc "AI-native localization framework — format-aware parsing and pluggable tools"
  homepage "https://github.com/neokapi/neokapi"
  version "1.2.0-rc17"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-pdfium"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc17/kapi-cli_1.2.0-rc17_darwin_arm64.tar.gz"
      sha256 "60e2224f415656e0b247675b3557f7d3fde4d229ccb5fab1c18358db103f37a5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc17/kapi-cli_1.2.0-rc17_linux_arm64.tar.gz"
      sha256 "81fc168d367449d3076dfd67e173cebd36d15a385ac223dc8be6b975aa364379"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc17/kapi-cli_1.2.0-rc17_linux_amd64.tar.gz"
      sha256 "7841b9435ce2f653e01796cff24df376f1af9586295b3864ae856162e94432c2"
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
