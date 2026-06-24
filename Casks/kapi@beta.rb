cask "kapi@beta" do
  version "1.2.0-rc7"
  sha256 "2753c94cd1965f2200ef9751d86b820e496af8086f50adc3bbf35e85c89fba4e"

  url "https://github.com/neokapi/neokapi/releases/download/v#{version}/kapi-#{version}-macOS-arm64.dmg"
  name "Kapi"
  desc "Localization toolkit - powered by neokapi"
  homepage "https://github.com/neokapi/neokapi"

  depends_on formula: "neokapi/tap/kapi-cli-beta"
  conflicts_with cask: "kapi"
  app "Kapi.app"

  postflight do
    system_command "/usr/bin/xattr",
                  args: ["-dr", "com.apple.quarantine", "#{appdir}/Kapi.app"],
                  sudo: false
  end

  caveats <<~EOS
    The kapi CLI is provided by the kapi-cli-beta formula (installed
    automatically). Run "kapi" for command-line usage.
  EOS

  zap trash: [
    "~/Library/Application Support/Kapi",
    "~/Library/Preferences/io.github.neokapi.kapi-desktop.plist",
    "~/Library/Caches/Kapi",
  ]
end
