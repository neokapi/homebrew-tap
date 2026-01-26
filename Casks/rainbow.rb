cask "rainbow" do
  version "0.1.3"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"

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
