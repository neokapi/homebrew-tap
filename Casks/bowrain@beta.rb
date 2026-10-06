cask "bowrain@beta" do
  version "1.3.0-rc4"
  sha256 "3cf8581d159c1ecfaac3ad3c2722870f0e66c55070150ad6b22bca25167c8643"

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
