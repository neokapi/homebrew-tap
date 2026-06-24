class BowrainCliBeta < Formula
  desc "Bowrain plugin for kapi — sync .kapi projects with Bowrain Server"
  homepage "https://github.com/neokapi/neokapi"
  version "1.2.0-rc7"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-cli-beta"
  conflicts_with "bowrain-cli", because: "both install the bowrain plugin"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc7/kapi-bowrain_1.2.0-rc7_darwin_arm64.tar.gz"
      sha256 "957d06ee8cddda37c37d6d04db8e11d92b6508e0fc917904d1247ce250cf669f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc7/kapi-bowrain_1.2.0-rc7_linux_arm64.tar.gz"
      sha256 "d8317c4cc6079246ca1c5f2424c2bb6c76bcedcc72cbbe87579d6dea935fa2a5"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc7/kapi-bowrain_1.2.0-rc7_linux_amd64.tar.gz"
      sha256 "ff9259862144c8f263014d281144b8d56db9cbc5a55f794ed85b8474812c5b31"
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
