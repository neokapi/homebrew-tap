class KapiPdfium < Formula
  desc "PDFium-backed PDF reader plugin for kapi — correct text (incl. CID/CJK) + geometry"
  homepage "https://github.com/neokapi/neokapi/tree/main/plugins/pdfium"
  version "0.1.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/pdfium-v0.1.1/kapi-pdfium_0.1.1_darwin_arm64.tar.gz"
      sha256 "e57f53020446799d8d719ef8d3c9a9858f907ffe5c89ac9c12858e259567c72a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/pdfium-v0.1.1/kapi-pdfium_0.1.1_linux_arm64.tar.gz"
      sha256 "d93c1017c3caf170e7244511e086934bdc7c6c3aa748e39f3188dcb8fc657d3f"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/pdfium-v0.1.1/kapi-pdfium_0.1.1_linux_amd64.tar.gz"
      sha256 "8c2e9351c1ca1bc60988c368824641f8b15efb854e6b452c4d17fc3bb5d629ef"
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
