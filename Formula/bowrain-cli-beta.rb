class BowrainCliBeta < Formula
  desc "Bowrain plugin for kapi — sync .kapi projects with Bowrain Server"
  homepage "https://github.com/neokapi/neokapi"
  version "1.2.0-rc5"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-cli-beta"
  conflicts_with "bowrain-cli", because: "both install the bowrain plugin"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc5/kapi-bowrain_1.2.0-rc5_darwin_arm64.tar.gz"
      sha256 "7c4cde1498c5593d16dfae02ecdfb55fc8cd2f1b782e2d46100ac6702a372558"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc5/kapi-bowrain_1.2.0-rc5_linux_arm64.tar.gz"
      sha256 "afc968d07d72935e8ea9d6cf728a2cf856f135422bc2c1860acadbf79af8a481"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc5/kapi-bowrain_1.2.0-rc5_linux_amd64.tar.gz"
      sha256 "79874f41218cf693f5b03581f23fcbd15fca9363f3fd35f5a36d0d68ddafc697"
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
