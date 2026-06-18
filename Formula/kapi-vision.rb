class KapiVision < Formula
  desc "Document-vision (OCR) plugin for kapi — PP-OCRv5 text recognition"
  homepage "https://github.com/neokapi/neokapi/tree/main/plugins/vision"
  version "0.1.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/vision-v0.1.0/kapi-vision_0.1.0_darwin_arm64.tar.gz"
      sha256 "27b533b288ddbe0dadfd9dbd1a297419efbb713c56ed7b65a930d5a059f31de1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/vision-v0.1.0/kapi-vision_0.1.0_linux_arm64.tar.gz"
      sha256 "cd970ae22a6dcd0c02dd10296b4560bc0fed341af813e461ab9960ea81f8e676"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/vision-v0.1.0/kapi-vision_0.1.0_linux_amd64.tar.gz"
      sha256 "9274498127a20dae3e824bddf376e909ac8a975b15758efc940befb65bd3d081"
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
