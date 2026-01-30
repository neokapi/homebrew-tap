require_relative "../lib/private_download_strategy"

cask "bowrain" do
  version "0.1.2"
  sha256 "30b7aec593056a29c743f5036b05cf0145d470c7ca88256540daef20c615cc6b"

  url "https://github.com/gokapi/gokapi/releases/download/v#{version}/bowrain-#{version}-macOS-universal.dmg",
      using: GitHubPrivateRepositoryReleaseDownloadStrategy
  name "Bowrain"
  desc "AI-native translation editor"
  homepage "https://github.com/gokapi/gokapi"

  app "Bowrain.app"
end
