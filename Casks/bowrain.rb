# Use absolute tap path so the require works even when Homebrew loads
# the cask from its metadata cache during upgrades.
require "#{Tap.fetch("neokapi", "tap").path}/lib/private_download_strategy"

cask "bowrain" do
  version "1.0.5"
  sha256 "e50bc043e0c15c1a9d816fd42c42105979cf1abf0613abacc27cba6fb0f9223a"

  url "https://github.com/neokapi/neokapi/releases/download/v#{version}/bowrain-#{version}-macOS-arm64.dmg",
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
