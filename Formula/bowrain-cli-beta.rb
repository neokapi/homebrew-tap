class BowrainCliBeta < Formula
  desc "Bowrain plugin for kapi — sync .kapi projects with Bowrain Server"
  homepage "https://github.com/neokapi/neokapi"
  version "1.2.0-rc6"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-cli-beta"
  conflicts_with "bowrain-cli", because: "both install the bowrain plugin"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc6/kapi-bowrain_1.2.0-rc6_darwin_arm64.tar.gz"
      sha256 "15e3ba4f72ab11efd2a663915e24be8e981d85e5b14b475e49a35a071c2efc71"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc6/kapi-bowrain_1.2.0-rc6_linux_arm64.tar.gz"
      sha256 "f0f20d221494f8172a965b6efdd411648eeed1adffc9a8c9a0ad38dd57a4eb08"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc6/kapi-bowrain_1.2.0-rc6_linux_amd64.tar.gz"
      sha256 "b965072804efa1f1a204d7e829a591acab0452a7b160b9c496337a2b1a99c4ab"
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
