class BowrainCliBeta < Formula
  desc "Bowrain plugin for kapi — sync .kapi projects with Bowrain Server"
  homepage "https://github.com/neokapi/neokapi"
  version "1.2.0-rc4"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-cli-beta"
  conflicts_with "bowrain-cli", because: "both install the bowrain plugin"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc4/kapi-bowrain_1.2.0-rc4_darwin_arm64.tar.gz"
      sha256 "a29ef636ba4883bd635685882a0a65655abc287be46676e0a27abab2f9a9ed2f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc4/kapi-bowrain_1.2.0-rc4_linux_arm64.tar.gz"
      sha256 "6158bf690496fea8ceb16a788646653da07817052ea30abb846a5382b57c07ce"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc4/kapi-bowrain_1.2.0-rc4_linux_amd64.tar.gz"
      sha256 "5b1e7f991b5f0b1935eb80f323ad55eda23b171c2e96fa95ea013ebce45b0f9f"
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
