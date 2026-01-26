cask "rainbow" do
  version "0.1.6"
  sha256 "38c174909fffd32238ad895f54a30cce8e1444981e3d7d1be3ed97f35969368b"

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
