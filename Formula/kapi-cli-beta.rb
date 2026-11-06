class KapiCliBeta < Formula
  desc "Format-aware content engine — parse, edit and check any format"
  homepage "https://github.com/neokapi/neokapi"
  version "1.3.0"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-pdfium"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.3.0/kapi-cli_1.3.0_darwin_arm64.tar.gz"
      sha256 "06a671cbf4fb07715968351a1831a871516a0e673e532cb7e7c8cca4b7a38297"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.3.0/kapi-cli_1.3.0_linux_arm64.tar.gz"
      sha256 "829b0c88125847e2fef58431b2f77db8de75cfd3d1f47fd7209113072bb63460"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.3.0/kapi-cli_1.3.0_linux_amd64.tar.gz"
      sha256 "bd359671124c6cd5b615eb5b786b4754780e6d6df77e5dcc26a815e183130e80"
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
