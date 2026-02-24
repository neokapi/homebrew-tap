# Use absolute tap path so the require works even when Homebrew loads
# the cask from its metadata cache during upgrades.
require "#{Tap.fetch("gokapi", "tap").path}/lib/private_download_strategy"

cask "bowrain" do
  version "0.21.0"
  sha256 "c7af240c60b9e0b5c2fff4cd8005b33a2204ccb4d0a410efc76e32b5ec1f8d6b"

  url "https://github.com/gokapi/gokapi/releases/download/v#{version}/bowrain-#{version}-macOS-universal.dmg",
      using: GitHubPrivateRepositoryReleaseDownloadStrategy
  name "Bowrain"
  desc "AI-native translation editor"
  homepage "https://github.com/gokapi/gokapi"

  app "Bowrain.app"
  binary "Bowrain.app/Contents/Resources/bin/bowrain", target: "bowrain"

  postflight do
    system_command "/usr/bin/xattr",
                  args: ["-dr", "com.apple.quarantine", "#{appdir}/Bowrain.app"],
                  sudo: false
  end

  caveats <<~EOS
    If Bowrain.app was previously installed from a DMG, run:
      brew install --cask --force gokapi/tap/bowrain
    to let Homebrew manage it. Future upgrades will work normally.
  EOS

  zap trash: [
    "~/Library/Application Support/Bowrain",
    "~/Library/Preferences/com.wails.bowrain.plist",
    "~/Library/Caches/Bowrain",
  ]
end
