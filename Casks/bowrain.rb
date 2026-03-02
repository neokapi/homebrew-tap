# Use absolute tap path so the require works even when Homebrew loads
# the cask from its metadata cache during upgrades.
require "#{Tap.fetch("gokapi", "tap").path}/lib/private_download_strategy"

cask "bowrain" do
  version "0.24.0"
  sha256 "674c0825a5679d8af9cc2379117ccd5f3e14643c06b01cadc239c55a4765ba2c"

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
