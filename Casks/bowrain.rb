# Use absolute tap path so the require works even when Homebrew loads
# the cask from its metadata cache during upgrades.
require "#{Tap.fetch("gokapi", "tap").path}/lib/private_download_strategy"

cask "bowrain" do
  version "0.9.0"
  sha256 "6fbd24b2c8e57d8dc8dd69dd8b7fe4ce4a869e9cc2f5cab9306c7c32aff82afb"

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
