require "#{Tap.fetch("neokapi", "tap").path}/lib/private_download_strategy"

class BowrainCli < Formula
  desc "Bowrain plugin for kapi — sync .kapi projects with Bowrain Server"
  homepage "https://github.com/neokapi/neokapi"
  version "1.1.1"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-cli"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.1.1/kapi-bowrain_1.1.1_darwin_arm64.tar.gz", using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "313afdced77ddffd7e6f8cd9214bd11144738559dda6c1d9a4867f440f66d7f7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.1.1/kapi-bowrain_1.1.1_linux_arm64.tar.gz", using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "5bb96ce3334f1da96f5ecaa8a23a17eaf3a027d0d16b838bd341caf9eb394d66"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.1.1/kapi-bowrain_1.1.1_linux_amd64.tar.gz", using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "e8f6584b039314454edab5aa708c4e0e632604c52c98f5f307c1cfebfa4889b4"
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
