cask "bowrain@beta" do
  version "1.4.0-rc4"
  sha256 "52f237091788b86ed1c530217113a3234e91807fa5aa713aedcafe5d5c96c1cf"

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
