# Use absolute tap path so the require works even when Homebrew loads
# the cask from its metadata cache during upgrades.
require "#{Tap.fetch("neokapi", "tap").path}/lib/private_download_strategy"

cask "kapi" do
  version "1.2.0"
  sha256 "45a25000e21628accc4ff3ebeece79812030006c943c6e49764f5a1f591d5d1e"

  url "https://github.com/neokapi/neokapi/releases/download/v#{version}/kapi-desktop-#{version}-macOS-arm64.dmg",
      using: GitHubPrivateRepositoryReleaseDownloadStrategy
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
