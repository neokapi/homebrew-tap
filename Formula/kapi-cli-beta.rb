class KapiCliBeta < Formula
  desc "AI-native localization framework — format-aware parsing, concurrent pipelines, and pluggable tools"
  homepage "https://github.com/neokapi/neokapi"
  version "1.2.0-rc3"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-pdfium"
  conflicts_with "kapi-cli", because: "both install the kapi binary"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc3/kapi-cli_1.2.0-rc3_darwin_arm64.tar.gz"
      sha256 "810e54ec0c868a4cc2fa5ff0744fa8e18402ac178439903d840ab6f456057da7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc3/kapi-cli_1.2.0-rc3_linux_arm64.tar.gz"
      sha256 "c7af04d2cbf7a343f5b88de933cf311179bbbf8335f9ef425b8c46d991747118"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc3/kapi-cli_1.2.0-rc3_linux_amd64.tar.gz"
      sha256 "89ebccae7aaaa502083171ed1d9f111f6455fd00e19e2156f089f19745c9499a"
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
