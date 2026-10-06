class BowrainCliBeta < Formula
  desc "Bowrain plugin for kapi — sync .kapi projects with Bowrain Server"
  homepage "https://github.com/neokapi/neokapi"
  version "1.3.0-rc5"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-cli-beta"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/bowrain-v1.3.0-rc5/kapi-bowrain_1.3.0-rc5_darwin_arm64.tar.gz"
      sha256 "a7d782b3baede9476e55c7620309acfa47c590fdb0a06b0fc19f6f34dfaeb34e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/bowrain-v1.3.0-rc5/kapi-bowrain_1.3.0-rc5_linux_arm64.tar.gz"
      sha256 "c94e21dc4c6b934d26b9e18fdc31fbfd8456f1d0392dbdb1a4385135ff698bc8"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/bowrain-v1.3.0-rc5/kapi-bowrain_1.3.0-rc5_linux_amd64.tar.gz"
      sha256 "fc3cd7c7143206961e1c7d1faf58c1df774fa9bbda948e8dcf0fd6014d47f613"
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
