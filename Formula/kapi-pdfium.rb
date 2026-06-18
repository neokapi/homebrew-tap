class KapiPdfium < Formula
  desc "PDFium-backed PDF reader plugin for kapi — correct text (incl. CID/CJK) + geometry"
  homepage "https://github.com/neokapi/neokapi/tree/main/plugins/pdfium"
  version "0.1.3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/pdfium-v0.1.3/kapi-pdfium_0.1.3_darwin_arm64.tar.gz"
      sha256 "b2235a24a15714cd63c734029b4083879cd34ac91b7c0e873c42e3ec5e06068c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/pdfium-v0.1.3/kapi-pdfium_0.1.3_linux_arm64.tar.gz"
      sha256 "9f4473b1532309c61159d44dc5160fbf50856fab53b0967fff58cf16fd27f992"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/pdfium-v0.1.3/kapi-pdfium_0.1.3_linux_amd64.tar.gz"
      sha256 "d7038ee60a61cef6dd50d3b630fa89a79b3df0e476d14a302f0d109921ef8fd3"
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
