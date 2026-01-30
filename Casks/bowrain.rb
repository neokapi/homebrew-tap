require_relative "../lib/private_download_strategy"

cask "bowrain" do
  version "0.1.3"
  sha256 "89a5121f4e258114c8bd12d70b1decd36752802ac0d2c651fac0852cc60e7701"

  url "https://github.com/gokapi/gokapi/releases/download/v#{version}/bowrain-#{version}-macOS-universal.dmg",
      using: GitHubPrivateRepositoryReleaseDownloadStrategy
  name "Bowrain"
  desc "AI-native translation editor"
  homepage "https://github.com/gokapi/gokapi"

  app "Bowrain.app"
end
