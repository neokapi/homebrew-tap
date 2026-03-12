# Use absolute tap path so the require works even when Homebrew loads
# the cask from its metadata cache during upgrades.
require "#{Tap.fetch("neokapi", "tap").path}/lib/private_download_strategy"

cask "bowrain" do
  version "0.28.7"
  sha256 "5ef8dcb3b478762ee9436f3693ed17065aac57395c319cec42c4bf4e4ede5bde"

  url "https://github.com/neokapi/neokapi/releases/download/v#{version}/bowrain-#{version}-macOS-universal.dmg",
      using: GitHubPrivateRepositoryReleaseDownloadStrategy
  name "Bowrain"
  desc "AI-native translation editor"
  homepage "https://github.com/neokapi/neokapi"

  depends_on formula: "neokapi/tap/bowrain-cli"

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
