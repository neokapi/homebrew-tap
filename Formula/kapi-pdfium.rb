class KapiPdfium < Formula
  desc "PDFium-backed PDF reader plugin for kapi (correct CID/CJK text + geometry)"
  homepage "https://github.com/neokapi/neokapi/tree/main/plugins/pdfium"
  version "0.1.4"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/pdfium-v0.1.4/kapi-pdfium_0.1.4_darwin_arm64.tar.gz"
      sha256 "6548f871900423bac05170a5969d81555c0ff0d026a1436b49c9493072bf3ebd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/pdfium-v0.1.4/kapi-pdfium_0.1.4_linux_arm64.tar.gz"
      sha256 "69ee7e8f029edde71bdfcb71bc2e298ca50e5a03894b4a6842c371bcd498ede9"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/pdfium-v0.1.4/kapi-pdfium_0.1.4_linux_amd64.tar.gz"
      sha256 "c5bef6e781e675ff5886a31bad17decaf2b2e3746a671ea22a34dd723e494309"
    end
  end

  # Plugin layout: kapi-pdfium binary + manifest.json + lib/<bundled libpdfium>.
  # Install the whole tree under the keg's own share/kapi/plugins/pdfium; Homebrew
  # then links it to HOMEBREW_PREFIX/share/kapi/plugins/pdfium, the shared kapi
  # plugins root `kapi` discovers. Installing into the keg (rather than writing
  # HOMEBREW_PREFIX directly) keeps the install sandbox-safe and lets
  # `brew uninstall` clean up. No depends_on kapi-cli — that would cycle, since
  # kapi-cli depends_on this.
  def install
    (share/"kapi/plugins/pdfium").install Dir["*"]
  end

  test do
    # Bare invocation prints the self-check line and exits 0; this also exercises
    # that the bundled libpdfium resolves via the binary's rpath.
    assert_match "kapi-pdfium", shell_output("#{share}/kapi/plugins/pdfium/kapi-pdfium 2>&1")
  end
end
