class BowrainCliBeta < Formula
  desc "Bowrain plugin for kapi — sync .kapi projects with Bowrain Server"
  homepage "https://github.com/neokapi/neokapi"
  version "1.2.0-rc3"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-cli-beta"
  conflicts_with "bowrain-cli", because: "both install the bowrain plugin"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc3/kapi-bowrain_1.2.0-rc3_darwin_arm64.tar.gz"
      sha256 "aa1be816eae7bd055f0e22b2e1bff70bbb3f952956c3d7ef9984c450bda952f0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc3/kapi-bowrain_1.2.0-rc3_linux_arm64.tar.gz"
      sha256 "fd5bf025f806d3e779bb37f9f16cfa59690d22bd07e2634965bf27ed0f31808f"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc3/kapi-bowrain_1.2.0-rc3_linux_amd64.tar.gz"
      sha256 "f2f4b20af41c2befe14cf574d4549e30a98b4e12e9df6f722a5161df93dee59e"
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
