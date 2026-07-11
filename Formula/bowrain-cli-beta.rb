class BowrainCliBeta < Formula
  desc "Bowrain plugin for kapi — sync .kapi projects with Bowrain Server"
  homepage "https://github.com/neokapi/neokapi"
  version "1.2.0-rc8"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-cli-beta"
  conflicts_with "bowrain-cli", because: "both install the bowrain plugin"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/bowrain-v1.2.0-rc8/kapi-bowrain_1.2.0-rc8_darwin_arm64.tar.gz"
      sha256 "59bf1627c8d03eac18447c30c9847fc1532c94914d3c1edc3d2ad4c95303cef9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/bowrain-v1.2.0-rc8/kapi-bowrain_1.2.0-rc8_linux_arm64.tar.gz"
      sha256 "da0773f8a09ff3e0017e5b614bb91d8e08ae5bc677dda84c85b14c1fda9f3a9b"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/bowrain-v1.2.0-rc8/kapi-bowrain_1.2.0-rc8_linux_amd64.tar.gz"
      sha256 "6bea3ec3df24bfb961f1d88c70d14d4f4cd04fea345db00291be75bc72e7e1d4"
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


  # Absorb macOS Gatekeeper's one-time first-exec assessment of the plugin
  # binary at install time instead of stalling the first bowrain command.
  def post_install
    system pkgshare/"plugins/bowrain/kapi-bowrain", "version"
  end

  test do
    system HOMEBREW_PREFIX/"share/kapi/plugins/bowrain/kapi-bowrain", "version"
  end
end
