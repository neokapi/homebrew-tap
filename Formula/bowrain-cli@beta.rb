class BowrainCliATBeta < Formula
  desc "Bowrain plugin for kapi — sync .kapi projects with Bowrain Server"
  homepage "https://github.com/neokapi/neokapi"
  version "1.2.0-rc1"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-cli@beta"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc1/kapi-bowrain_1.2.0-rc1_darwin_arm64.tar.gz"
      sha256 "55b376152f74c3ea62ab3ae7dac494b57fb479e568b6391494a425f8ef66e285"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc1/kapi-bowrain_1.2.0-rc1_linux_arm64.tar.gz"
      sha256 "871fe33f5cbfdecc38db1fe5717b115599c3e1dc3a972c1193350bc158755776"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc1/kapi-bowrain_1.2.0-rc1_linux_amd64.tar.gz"
      sha256 "c43a3e7df295446466749b8758f421cede0a4fc3ef3b6fd29d4b8ec15ff033ea"
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
