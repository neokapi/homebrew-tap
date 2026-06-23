class BowrainCliATBeta < Formula
  desc "Bowrain plugin for kapi — sync .kapi projects with Bowrain Server"
  homepage "https://github.com/neokapi/neokapi"
  version "1.2.0-rc1"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-cli@beta"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc1/kapi-bowrain_1.2.0-rc1_darwin_arm64.tar.gz"
      sha256 "e51193b86a07cbb34d5cbc802add97a2956bb2f54b6dd224a8f293c5969a087f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc1/kapi-bowrain_1.2.0-rc1_linux_arm64.tar.gz"
      sha256 "152ce857240723a699674e5af74f1278783783d08c0e407ae995726cafd20a6f"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc1/kapi-bowrain_1.2.0-rc1_linux_amd64.tar.gz"
      sha256 "adbba292f5261cb95e5183dc8bcab2da7309bd9942925a393e7210fe66cbb85c"
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
