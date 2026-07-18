class KapiCliBeta < Formula
  desc "AI-native localization framework — format-aware parsing, concurrent pipelines, and pluggable tools"
  homepage "https://github.com/neokapi/neokapi"
  version "1.2.0-rc12"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-pdfium"
  conflicts_with "kapi-cli", because: "both install the kapi binary"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc12/kapi-cli_1.2.0-rc12_darwin_arm64.tar.gz"
      sha256 "7c712419ff08f67e606d60aaf952fb898c9edf1a5979f6cc3f6025758cb91db3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc12/kapi-cli_1.2.0-rc12_linux_arm64.tar.gz"
      sha256 "590d1207bd565c9f2b40a2eedae0473bf39ef517ed386b54da74f5eac69bcb91"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc12/kapi-cli_1.2.0-rc12_linux_amd64.tar.gz"
      sha256 "82232d339bc515428b75e354dcea16bf2e6d34589ec3ccb17c98fa6118e8176a"
    end
  end

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
