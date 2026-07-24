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
      sha256 "5f8e7392cf561c95fe40780d2e6e961662e440432c19b4da36a5f194a06455e8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/bowrain-v1.2.0-rc15/kapi-bowrain_1.2.0-rc15_linux_arm64.tar.gz"
      sha256 "5a0d1a2b91267b5fb8ed4f66a0eb493fb78be717a2306818384d61b5e264d5de"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/bowrain-v1.2.0-rc15/kapi-bowrain_1.2.0-rc15_linux_amd64.tar.gz"
      sha256 "564bbae7d94c004a634d7801338b79b7946da5f1e8d8097b2fe2dca2aab55627"
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
