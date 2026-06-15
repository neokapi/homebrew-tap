class BowrainCli < Formula
  desc "Bowrain plugin for kapi — sync .kapi projects with Bowrain Server"
  homepage "https://github.com/neokapi/neokapi"
  version "1.0.1"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-cli"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.0.1/kapi-bowrain_1.0.1_darwin_arm64.tar.gz"      sha256 "b4970fe273f9462ab718ebc1c8eeec678c0102b9d54f84ca26904eb46bfe578e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.0.1/kapi-bowrain_1.0.1_linux_arm64.tar.gz"      sha256 "10b2ecac2d321bdc7fb92500e3b04774f159cbf911cafb6045527f923b4b988b"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.0.1/kapi-bowrain_1.0.1_linux_amd64.tar.gz"      sha256 "99e94854ca576c97976fbb31239795f8ac116e20b40b36bf447626e1d5e75ecc"
    end
  end

  def install
    plugin_dir = pkgshare/"plugins/bowrain"
    plugin_dir.mkpath
    plugin_dir.install Dir["bowrain/*"]
    # Symlink so HOMEBREW_PREFIX/share/kapi/plugins/bowrain/ resolves
    # to this formula's pkgshare/plugins/bowrain/.
    kapi_share = HOMEBREW_PREFIX/"share/kapi/plugins"
    kapi_share.mkpath
    ln_sf plugin_dir, kapi_share/"bowrain"
  end

  test do
    system HOMEBREW_PREFIX/"share/kapi/plugins/bowrain/kapi-bowrain", "version"
  end
end
