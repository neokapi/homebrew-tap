class KapiVision < Formula
  desc "Document-vision plugin for kapi — PP-OCRv5 OCR + PP-DocLayoutV3 layout"
  homepage "https://github.com/neokapi/neokapi/tree/main/plugins/vision"
  version "0.2.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/vision-v0.2.0/kapi-vision_0.2.0_darwin_arm64.tar.gz"
      sha256 "cb00081095b892491b5a588eeca5add9896ede2bf7c76cec5564f34b39882e7b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/vision-v0.2.0/kapi-vision_0.2.0_linux_arm64.tar.gz"
      sha256 "4e91df9378500a46c13528023d7df354622a56bba7704b56f1751963c8a98c8d"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/vision-v0.2.0/kapi-vision_0.2.0_linux_amd64.tar.gz"
      sha256 "a6750c00d74493feff0db580ef85f6c61bce50027f8ef9961755c7c9da603c30"
    end
  end

  # Plugin layout: kapi-vision binary + manifest.json + lib/<bundled onnxruntime>
  # + models/<PP-OCRv5 assets>. Install the whole self-contained tree into
  # pkgshare and symlink it into the shared kapi plugins root so `kapi` discovers
  # it (no depends_on kapi-cli — OCR is opt-in, not bundled with the CLI).
  def install
    plugin_dir = pkgshare/"plugins/vision"
    plugin_dir.install Dir["*"]
    kapi_share = HOMEBREW_PREFIX/"share/kapi/plugins"
    kapi_share.mkpath
    ln_sf plugin_dir, kapi_share/"vision"
  end

  test do
    # The self-check constructs the engine (loading the bundled onnxruntime via
    # the binary's rpath) and lists the model assets, then exits 0.
    assert_match "kapi-vision",
      shell_output("#{HOMEBREW_PREFIX}/share/kapi/plugins/vision/kapi-vision command vision 2>&1")
  end
end
