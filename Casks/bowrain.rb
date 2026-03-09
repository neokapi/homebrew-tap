# Use absolute tap path so the require works even when Homebrew loads
# the cask from its metadata cache during upgrades.
require "#{Tap.fetch("gokapi", "tap").path}/lib/private_download_strategy"

cask "bowrain" do
  version "0.28.4"
  sha256 "86a8bdd8c1dfc4cbc7ecce25ed597112c8999cde400231bbdc79f3efa29d3426"

  url "https://github.com/gokapi/gokapi/releases/download/v#{version}/bowrain-#{version}-macOS-universal.dmg",
      using: GitHubPrivateRepositoryReleaseDownloadStrategy
  name "Bowrain"
  desc "AI-native translation editor"
  homepage "https://github.com/gokapi/gokapi"

  depends_on formula: "gokapi/tap/bowrain-cli"

  app "Bowrain.app"

  postflight do
    system_command "/usr/bin/xattr",
                  args: ["-dr", "com.apple.quarantine", "#{appdir}/Bowrain.app"],
                  sudo: false
  end

  caveats <<~EOS
    The bowrain CLI is provided by the bowrain-cli formula (installed
    automatically). Run "bowrain ui" to launch the desktop app.
  EOS

  zap trash: [
    "~/Library/Application Support/Bowrain",
    "~/Library/Preferences/com.wails.bowrain.plist",
    "~/Library/Caches/Bowrain",
  ]
end
