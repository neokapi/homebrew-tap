cask "rainbow" do
  version "0.1.9"
  sha256 "658c15be56f14481bbed86f735313f6e28103377da8ed30d107e2ce23e9708e1"

  url "https://github.com/gokapi/gokapi/releases/download/v#{version}/Rainbow-#{version}-macOS-universal.dmg"
  name "Rainbow"
  desc "Visual localization quality assurance tool"
  homepage "https://github.com/gokapi/gokapi"

  app "rainbow.app", target: "Rainbow.app"

  # Remove quarantine bit for unsigned app
  postflight do
    system_command "/usr/bin/xattr",
                  args: ["-dr", "com.apple.quarantine", "#{appdir}/Rainbow.app"],
                  sudo: false
  end

  zap trash: [
    "~/Library/Application Support/rainbow",
    "~/Library/Preferences/com.wails.rainbow.plist",
    "~/Library/Caches/rainbow",
  ]
end
