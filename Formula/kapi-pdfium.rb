class KapiPdfium < Formula
  desc "PDFium-backed PDF reader plugin for kapi — correct text (incl. CID/CJK) + geometry"
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
  # Install the whole tree into pkgshare and symlink it into the shared kapi
  # plugins root so `kapi` discovers it (no depends_on kapi-cli — that would
  # cycle, since kapi-cli depends_on this).
  def install
    plugin_dir = pkgshare/"plugins/pdfium"
    plugin_dir.install Dir["*"]
    kapi_share = HOMEBREW_PREFIX/"share/kapi/plugins"
    kapi_share.mkpath
    ln_sf plugin_dir, kapi_share/"pdfium"
  end

  test do
    # Bare invocation prints the self-check line and exits 0; this also exercises
    # that the bundled libpdfium resolves via the binary's rpath.
    assert_match "kapi-pdfium", shell_output("#{HOMEBREW_PREFIX}/share/kapi/plugins/pdfium/kapi-pdfium 2>&1")
  end
end
