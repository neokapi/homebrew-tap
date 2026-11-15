class KapiCliBeta < Formula
  desc "Format-aware content engine — parse, edit and check any format"
  homepage "https://github.com/neokapi/neokapi"
  version "1.4.0-rc3"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-pdfium"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.4.0-rc3/kapi-cli_1.4.0-rc3_darwin_arm64.tar.gz"
      sha256 "1e499105c3a31fcab5763a1b52ac1c2fca77e701e8aba155a783e34ede274651"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.4.0-rc3/kapi-cli_1.4.0-rc3_linux_arm64.tar.gz"
      sha256 "022d54ad645f9aed6de5edcf996b918b4ff2f332d860b205c5025a1c98b9a870"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.4.0-rc3/kapi-cli_1.4.0-rc3_linux_amd64.tar.gz"
      sha256 "19f1da195a324b54c771ce1392b6cb0bcc16216609b6667ae0d8ba5e24b54246"
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
