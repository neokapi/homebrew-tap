class BowrainCli < Formula
  desc "Bowrain plugin for kapi — sync .kapi projects with Bowrain Server"
  homepage "https://github.com/neokapi/neokapi"
  version "1.0.2"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-cli"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.0.2/kapi-bowrain_1.0.2_darwin_arm64.tar.gz"
      sha256 "e32748bea21fbc3e7c3611c61cc4c272a96e8fbe65838941b5f27f4c2b47c713"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.0.2/kapi-bowrain_1.0.2_linux_arm64.tar.gz"
      sha256 "47d6b7097c037ac8fb3ec1c20ad39d2a6965fdfee7393e2a69a0a47cec875054"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.0.2/kapi-bowrain_1.0.2_linux_amd64.tar.gz"
      sha256 "a11e6094dd3fdfe42c978b5268dee4465463912ea3206f5cd6c00dd3ca4b77a9"
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
