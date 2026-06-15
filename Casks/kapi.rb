cask "kapi" do
  version "1.0.2"
  sha256 "b310022a818788d8b8a24d0fe283e39572b8a6021762e16733b9d579d0814ed6"

  url "https://github.com/neokapi/neokapi/releases/download/v#{version}/kapi-desktop-#{version}-macOS-arm64.dmg"
  name "Kapi"
  desc "Localization toolkit - powered by neokapi"
  homepage "https://github.com/neokapi/neokapi"

  depends_on formula: "neokapi/tap/kapi-cli"

  app "Kapi.app"

  postflight do
    system_command "/usr/bin/xattr",
                  args: ["-dr", "com.apple.quarantine", "#{appdir}/Kapi.app"],
                  sudo: false
  end

  caveats <<~EOS
    The kapi CLI is provided by the kapi-cli formula (installed
    automatically). Run "kapi" for command-line usage.
  EOS

  zap trash: [
    "~/Library/Application Support/Kapi",
    "~/Library/Preferences/io.github.neokapi.kapi-desktop.plist",
    "~/Library/Caches/Kapi",
  ]
end
