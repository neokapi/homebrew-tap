class BowrainCliBeta < Formula
  desc "Bowrain plugin for kapi — sync .kapi projects with Bowrain Server"
  homepage "https://github.com/neokapi/neokapi"
  version "1.3.0-rc10"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-cli-beta"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/bowrain-v1.3.0-rc10/kapi-bowrain_1.3.0-rc10_darwin_arm64.tar.gz"
      sha256 "01e832702ca06d8f69c7163f151127efa72da0a22975382c555428f5b8997ef7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/bowrain-v1.3.0-rc10/kapi-bowrain_1.3.0-rc10_linux_arm64.tar.gz"
      sha256 "6d5855d0536a364c7a1fcc1df4f018e2918872d522aae566167b9eb2200f2e5c"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/bowrain-v1.3.0-rc10/kapi-bowrain_1.3.0-rc10_linux_amd64.tar.gz"
      sha256 "4fe56dcaa132578a5be86f76489ab8c45563db907ea499fb79638c41b50b041b"
    end
  end

  conflicts_with "bowrain-cli", because: "both install the bowrain plugin"

  # Plugin layout: kapi-bowrain binary + manifest.json, under a single `bowrain/`
  # top-level directory. Homebrew chdirs into that directory before `install`
  # runs, so the staged tree is flat — glob "*", not "bowrain/*" (which matches
  # nothing and installs an empty array). Install the whole tree under the keg's
  # own share/kapi/plugins/bowrain; Homebrew then links it to
  # HOMEBREW_PREFIX/share/kapi/plugins/bowrain, the shared kapi plugins root
  # `kapi` discovers. Installing into the keg (rather than symlinking into
  # HOMEBREW_PREFIX, which the install sandbox denies with EPERM because that
  # path belongs to another formula) keeps the install sandbox-safe and lets
  # `brew uninstall` clean up.
  def install
    (share/"kapi/plugins/bowrain").install Dir["*"]
  end

  # Absorb macOS Gatekeeper's one-time first-exec assessment of the plugin
  # binary at install time instead of stalling the first bowrain command.
  # Best-effort: a failure just means the first real exec pays it instead.
  post_install_steps do
    run "kapi/plugins/bowrain/kapi-bowrain", args: ["version"], base: :share, must_succeed: false
  end

  test do
    # The plugin binary reports the version it was built at; this also proves the
    # tree actually landed in the shared kapi plugins root rather than being a
    # silently-empty install.
    assert_match version.to_s,
      shell_output("#{share}/kapi/plugins/bowrain/kapi-bowrain version 2>&1")
  end
end
