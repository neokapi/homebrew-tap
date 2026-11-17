cask "kapi@beta" do
  version "1.4.0-rc5"
  sha256 "0355f5d70516764019be3b013009c595f0ee038f9b90ec6b3747b6c6162ad28c"

  url "https://github.com/neokapi/neokapi/releases/download/v#{version}/kapi-#{version}-macOS-arm64.dmg"
  name "Kapi"
  desc "Desktop workbench for a project's content context"
  homepage "https://github.com/neokapi/neokapi"

  conflicts_with cask: "kapi"
  depends_on formula: "neokapi/tap/kapi-cli-beta"
  depends_on :macos

  app "Kapi.app"

  zap trash: [
    "~/Library/Application Support/kapi-desktop",
    "~/Library/Caches/io.github.neokapi.kapi-desktop",
    "~/Library/Preferences/io.github.neokapi.kapi-desktop.plist",
    "~/Library/WebKit/io.github.neokapi.kapi-desktop",
  ]

  caveats <<~EOS
    The kapi CLI is provided by the kapi-cli-beta formula (installed
    automatically). Run "kapi" for command-line usage.
  EOS
end
