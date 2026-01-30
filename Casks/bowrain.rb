require_relative "../lib/private_download_strategy"

cask "bowrain" do
  version "0.1.1"
  sha256 "d03bebaf2205a2a7eac30b93cdb1e14a70f0a9b2cf028f35c4a73a2c0ffe913a"

  url "https://github.com/gokapi/gokapi/releases/download/v#{version}/bowrain-#{version}-macOS-universal.dmg",
      using: GitHubPrivateRepositoryReleaseDownloadStrategy
  name "Bowrain"
  desc "AI-native translation editor"
  homepage "https://github.com/gokapi/gokapi"

  app "Bowrain.app"
end
