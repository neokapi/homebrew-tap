cask "bowrain" do
  version "0.1.0"
  sha256 "07877a661dd631e17e53a604b6d927ae8317a72188db52ce8af387b5b113b1bb"

  url "https://github.com/gokapi/gokapi/releases/download/v#{version}/bowrain-#{version}-macOS-universal.dmg",
      headers: ["Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}"]
  name "Bowrain"
  desc "AI-native translation editor"
  homepage "https://github.com/gokapi/gokapi"

  app "Bowrain.app"
end
