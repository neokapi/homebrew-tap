# Use absolute tap path so the require works even when Homebrew loads
# the cask from its metadata cache during upgrades.

cask "kapi" do
  version "1.0.0"
  sha256 "37e15daa501d6e0332748142e148ecac0ee2e8a535469d9cc27b5d8f7db7887e"

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
