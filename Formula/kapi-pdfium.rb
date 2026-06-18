class KapiPdfium < Formula
  desc "PDFium-backed PDF reader plugin for kapi — correct text (incl. CID/CJK) + geometry"
  homepage "https://github.com/neokapi/neokapi/tree/main/plugins/pdfium"
  version "0.1.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/pdfium-v0.1.2/kapi-pdfium_0.1.2_darwin_arm64.tar.gz"
      sha256 "3680466fcd6cd2ff06a783f0e4d42b2e0fb34bbba8678f5a64ac577fd922d6d1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/pdfium-v0.1.2/kapi-pdfium_0.1.2_linux_arm64.tar.gz"
      sha256 "d3d5e2ae9d8cbcfe406da772ed7af7cd00197bdb3ca12a47347076d666e33efc"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/pdfium-v0.1.2/kapi-pdfium_0.1.2_linux_amd64.tar.gz"
      sha256 "fa5b5b36c8daf12ead9c117ad7c79b3d387e5d4601f017aa3ddd726aaa6f1062"
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
