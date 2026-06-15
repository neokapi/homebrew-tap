cask "bowrain" do
  version "1.0.2"
  sha256 "638dd9f6bc6dcfd537ba492082423dc2b739b4f298ffa2a463736a4dbe066384"

  url "https://github.com/neokapi/neokapi/releases/download/v#{version}/bowrain-#{version}-macOS-arm64.dmg"
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
