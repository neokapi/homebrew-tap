cask "bowrain@beta" do
  version "1.2.0"
  sha256 "ca1fb0b5c185ea1812d6d0d33f5ed93d026224bcb66751e2a4835e1532a3731f"

  url "https://github.com/neokapi/neokapi/releases/download/bowrain-v#{version}/bowrain-#{version}-macOS-arm64.dmg"
  name "Bowrain"
  desc "AI-native translation editor"
  homepage "https://github.com/neokapi/neokapi"

  depends_on formula: "neokapi/tap/bowrain-cli-beta"
  conflicts_with cask: "bowrain"
  app "Bowrain.app"

  postflight do
    system_command "/usr/bin/xattr",
                  args: ["-dr", "com.apple.quarantine", "#{appdir}/Bowrain.app"],
                  sudo: false
  end

  caveats <<~EOS
    The bowrain CLI is provided by the bowrain-cli-beta formula (installed
    automatically). Run "bowrain ui" to launch the desktop app.
  EOS

  zap trash: [
    "~/Library/Application Support/Bowrain",
    "~/Library/Preferences/com.wails.bowrain.plist",
    "~/Library/Caches/Bowrain",
  ]
end
