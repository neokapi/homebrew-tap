cask "rainbow" do
  version "0.1.5"
  sha256 "462e32d4363d930178ff478754e4c147e793f107f8f166de0cecc18fc69084eb"

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
