cask "bowrain@beta" do
  version "1.2.0-rc23"
  sha256 "784eaef4346420435f6e0e21df71e8dd83eb6e29a69f15adc23caf9691e6b86e"

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
