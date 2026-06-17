class KapiPdfium < Formula
  desc "PDFium-backed PDF reader plugin for kapi — correct text (incl. CID/CJK) + geometry"
  homepage "https://github.com/neokapi/neokapi/tree/main/plugins/pdfium"
  version "0.1.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/pdfium-v0.1.0/kapi-pdfium_0.1.0_darwin_arm64.tar.gz"
      sha256 "606af7239de03db0af6357594fd13b8176dcc1da8e74634953bc7f6f4dca217e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/pdfium-v0.1.0/kapi-pdfium_0.1.0_linux_arm64.tar.gz"
      sha256 "a536c95af7649df81176e628d379a978c2fc8c70b49cee3e70df36423c5695aa"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/pdfium-v0.1.0/kapi-pdfium_0.1.0_linux_amd64.tar.gz"
      sha256 "51cad054a6b9fd7225f09e2cb9fa4e227e973f08f5096a54cb42b964cfca58e7"
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
