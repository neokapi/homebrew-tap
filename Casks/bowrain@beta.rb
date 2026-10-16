cask "bowrain@beta" do
  version "1.3.0-rc9"
  sha256 "bd2b74263969c298a9532c375eb566690bff9f14988083c092419195711247fc"

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
