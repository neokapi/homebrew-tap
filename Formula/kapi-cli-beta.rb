class KapiCliBeta < Formula
  desc "Format-aware content engine — parse, edit and check any format"
  homepage "https://github.com/neokapi/neokapi"
  version "1.3.0-rc5"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-pdfium"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.3.0-rc5/kapi-cli_1.3.0-rc5_darwin_arm64.tar.gz"
      sha256 "a948fe6467793aa33082cbcc09f5e7ccef3479c230e7121dbdd6bbd2bc8d8cc7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.3.0-rc5/kapi-cli_1.3.0-rc5_linux_arm64.tar.gz"
      sha256 "5019ef9c1474fe36825bc943bac2e4d88e2c302ed0c6b0d0432bc6a8244faa5b"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.3.0-rc5/kapi-cli_1.3.0-rc5_linux_amd64.tar.gz"
      sha256 "a4896a2bed685546f33297edadfa3851fe97af39c2c00e44f9502407213d198f"
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
  # Best-effort: a failure means the first real exec pays the assessment.
  post_install_steps do
    run "kapi", args: ["--version"], base: :bin, must_succeed: false
  end

  test do
    system "#{bin}/kapi", "version"
    assert_match "grep", shell_output("#{bin}/kgrep --help 2>&1")
    assert_match "diff", shell_output("#{bin}/kdiff --help 2>&1")
  end
end
