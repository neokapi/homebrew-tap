class BowrainCli < Formula
  desc "Bowrain plugin for kapi — sync .kapi projects with Bowrain Server"
  homepage "https://github.com/neokapi/neokapi"
  version "1.0.0"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-cli"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.0.0/kapi-bowrain_1.0.0_darwin_arm64.tar.gz"
      sha256 "9c6dd51dd96494dbd83157454c2f8b3501ce237b7c60830d3cfb7306522281e3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.0.0/kapi-bowrain_1.0.0_linux_arm64.tar.gz"
      sha256 "ac349467f5252251dd7085fd28f3a45205064d6452d77e45e3e9d1b1d26a24be"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.0.0/kapi-bowrain_1.0.0_linux_amd64.tar.gz"
      sha256 "5194f2314310aced0570e375b2add1bbc81aaf77849820b26e6ad05c739c8dad"
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
