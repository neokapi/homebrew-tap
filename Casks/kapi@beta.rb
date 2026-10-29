cask "kapi@beta" do
  version "1.3.0-rc10"
  sha256 "f851cc8f388e3597a9bcac7e38f0057a7ff20da6863c1b409e0269b86aac8ba0"

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
