cask "bowrain" do
  version "0.1.9"
  sha256 "658c15be56f14481bbed86f735313f6e28103377da8ed30d107e2ce23e9708e1"

  url "https://github.com/gokapi/gokapi/releases/download/v#{version}/Bowrain-#{version}-macOS-universal.dmg"
  name "Bowrain"
  desc "Visual localization quality assurance tool"
  homepage "https://github.com/gokapi/gokapi"

  app "bowrain.app", target: "Bowrain.app"

  # Remove quarantine bit for unsigned app
  postflight do
    system_command "/usr/bin/xattr",
                  args: ["-dr", "com.apple.quarantine", "#{appdir}/Bowrain.app"],
                  sudo: false
  end

  zap trash: [
    "~/Library/Application Support/bowrain",
    "~/Library/Preferences/com.wails.bowrain.plist",
    "~/Library/Caches/bowrain",
  ]
end
