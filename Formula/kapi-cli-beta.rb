class KapiCliBeta < Formula
  desc "Format-aware content engine — parse, edit and check any format"
  homepage "https://github.com/neokapi/neokapi"
  version "1.3.0-rc8"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-pdfium"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.3.0-rc8/kapi-cli_1.3.0-rc8_darwin_arm64.tar.gz"
      sha256 "77cf17e7c1e2433005781bbfd69437d6b82407bab90b74bdf5ba36d55b0fcf49"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.3.0-rc8/kapi-cli_1.3.0-rc8_linux_arm64.tar.gz"
      sha256 "479bd4688bf159474d17c612473ede476d8e310334dd234915d53e641f5c3eb4"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.3.0-rc8/kapi-cli_1.3.0-rc8_linux_amd64.tar.gz"
      sha256 "8bb1a2874d33e7e693b9863eabde9ea12c9ae5aca4b2737f3eb5a1fc11df9a57"
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
