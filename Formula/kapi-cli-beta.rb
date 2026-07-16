class KapiCliBeta < Formula
  desc "AI-native localization framework — format-aware parsing, concurrent pipelines, and pluggable tools"
  homepage "https://github.com/neokapi/neokapi"
  version "1.2.0-rc11"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-pdfium"
  conflicts_with "kapi-cli", because: "both install the kapi binary"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc11/kapi-cli_1.2.0-rc11_darwin_arm64.tar.gz"
      sha256 "cfe9e4942d2468a4b5b6a65f338acba8a3f33ff5b00271d5c416403f78b927bf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc11/kapi-cli_1.2.0-rc11_linux_arm64.tar.gz"
      sha256 "1c003ac88398f3eb07f80612e1108cd53978a44c0a997910642016224a250ccb"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc11/kapi-cli_1.2.0-rc11_linux_amd64.tar.gz"
      sha256 "76721901c9c4e79d04269190edc7bb0fa8a43b4cb25a643baf8405c1e411cda9"
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
