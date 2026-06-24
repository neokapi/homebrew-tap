class KapiCliBeta < Formula
  desc "AI-native localization framework — format-aware parsing, concurrent pipelines, and pluggable tools"
  homepage "https://github.com/neokapi/neokapi"
  version "1.2.0-rc7"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-pdfium"
  conflicts_with "kapi-cli", because: "both install the kapi binary"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc7/kapi-cli_1.2.0-rc7_darwin_arm64.tar.gz"
      sha256 "36ede0c6ac8d39068f2bb12c3ef43dfa2c3981d9e71a1073a1b2acfab49cf071"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc7/kapi-cli_1.2.0-rc7_linux_arm64.tar.gz"
      sha256 "916a93ca1e142db9b4ead2e24220a1a09aee277ba0ae18720c6d4f8f7290fb8b"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc7/kapi-cli_1.2.0-rc7_linux_amd64.tar.gz"
      sha256 "cd422c5f54baa666a5d658ff13f7384bf9825e94d3735731c5de6c966a078914"
    end
  end

  # Install kapi plus its multi-call toolbox aliases. kgrep / ksed / kcat / kconv
  # are symlinks to the kapi binary, which dispatches on its invocation name
  # (busybox-style) — no extra binaries, no extra download size.
  def install
    bin.install "kapi"
    bin.install_symlink bin/"kapi" => "kgrep"
    bin.install_symlink bin/"kapi" => "ksed"
    bin.install_symlink bin/"kapi" => "kcat"
    bin.install_symlink bin/"kapi" => "kconv"
  end

  test do
    system "#{bin}/kapi", "version"
    assert_match "grep", shell_output("#{bin}/kgrep --help 2>&1")
  end
end
