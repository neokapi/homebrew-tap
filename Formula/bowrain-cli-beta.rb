class BowrainCliBeta < Formula
  desc "Bowrain plugin for kapi — sync .kapi projects with Bowrain Server"
  homepage "https://github.com/neokapi/neokapi"
  version "1.2.0-rc14"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-cli-beta"
  conflicts_with "bowrain-cli", because: "both install the bowrain plugin"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/bowrain-v1.2.0-rc14/kapi-bowrain_1.2.0-rc14_darwin_arm64.tar.gz"
      sha256 "1b36d5a52c527ca021e7ba65fad2fffc856f43e4e8f949764bfa382b3067545d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/bowrain-v1.2.0-rc14/kapi-bowrain_1.2.0-rc14_linux_arm64.tar.gz"
      sha256 "40a17952cd8173af90685aaefff4c59ed93e5c4c753235e695554fb0f22c5d21"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/bowrain-v1.2.0-rc14/kapi-bowrain_1.2.0-rc14_linux_amd64.tar.gz"
      sha256 "2ca7173deafa7c5d438474f899b8ee663f3a21aef8ef06d670b406ff7c067870"
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
