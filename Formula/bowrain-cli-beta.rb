class BowrainCliBeta < Formula
  desc "Bowrain plugin for kapi — sync .kapi projects with Bowrain Server"
  homepage "https://github.com/neokapi/neokapi"
  version "1.2.0-rc15"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-cli-beta"
  conflicts_with "bowrain-cli", because: "both install the bowrain plugin"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/bowrain-v1.2.0-rc15/kapi-bowrain_1.2.0-rc15_darwin_arm64.tar.gz"
      sha256 "b9060c8eb5bdb377d68a00103c8db3e807c95f7fb36b72f9bd3309c8badf76b9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/bowrain-v1.2.0-rc15/kapi-bowrain_1.2.0-rc15_linux_arm64.tar.gz"
      sha256 "4a1fb8023e0b43e9cee9c8ecedc833777cb2d26913a741be1e75e7b1028a8a60"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/bowrain-v1.2.0-rc15/kapi-bowrain_1.2.0-rc15_linux_amd64.tar.gz"
      sha256 "70f2668f62e842bfa87a55cafe90c5d1cd5fee98cee841e432f48a2f66827d08"
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
