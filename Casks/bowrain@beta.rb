cask "bowrain@beta" do
  version "1.3.0-rc8"
  sha256 "9a77ba0e013517773ebc7320b75a815c3fac597c3220fdc71531cbc640571de4"

  url "https://github.com/neokapi/neokapi/releases/download/bowrain-v#{version}/bowrain-#{version}-macOS-arm64.dmg"
  name "Bowrain"
  desc "Desktop client for a team's shared context graph, with offline editing"
  homepage "https://github.com/neokapi/neokapi"

  conflicts_with cask: "bowrain"
  depends_on formula: "neokapi/tap/bowrain-cli-beta"
  depends_on :macos

  app "Bowrain.app"

  zap trash: [
    "~/Library/Application Support/bowrain-desktop",
    "~/Library/Caches/io.github.neokapi.bowrain",
    "~/Library/Preferences/io.github.neokapi.bowrain.plist",
    "~/Library/WebKit/io.github.neokapi.bowrain",
  ]

  caveats <<~EOS
    kapi and the bowrain plugin come from the bowrain-cli-beta formula
    (installed automatically). Run "kapi ui" to launch the desktop app.
  EOS
end
