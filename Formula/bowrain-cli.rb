class BowrainCli < Formula
  desc "Bowrain plugin for kapi — sync .kapi projects with Bowrain Server"
  homepage "https://github.com/neokapi/neokapi"
  version "1.1.0"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-cli"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.1.0/kapi-bowrain_1.1.0_darwin_arm64.tar.gz"
      sha256 "7031f2458370068a99c4f73b73cc48239f3f4c35d355618d7f632ed1638aa339"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.1.0/kapi-bowrain_1.1.0_linux_arm64.tar.gz"
      sha256 "aaa73f283136e1ad2be02ba3b775eac67b226fcad2ef8de6e98304f3d18af4f3"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.1.0/kapi-bowrain_1.1.0_linux_amd64.tar.gz"
      sha256 "0ce0bd5863cf447bbf4ad5af971b5d916aed5bcdae2b4da2d17e47e2a62c633f"
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
