class BowrainCliBeta < Formula
  desc "Bowrain plugin for kapi — sync .kapi projects with Bowrain Server"
  homepage "https://github.com/neokapi/neokapi"
  version "1.4.0-rc2"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-cli-beta"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/bowrain-v1.4.0-rc2/kapi-bowrain_1.4.0-rc2_darwin_arm64.tar.gz"
      sha256 "c9c91bc519e5e196622397e6126602314693dca7f3f3a99ac327d9fd8843c956"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/bowrain-v1.4.0-rc2/kapi-bowrain_1.4.0-rc2_linux_arm64.tar.gz"
      sha256 "32a04c21e8978cdb0eb80e30c51ae98f4095ac8e3e6cfb74a70d8d0d0b81d195"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/bowrain-v1.4.0-rc2/kapi-bowrain_1.4.0-rc2_linux_amd64.tar.gz"
      sha256 "913ff9792bed415f632fa54f4bc592e0a452c97a9f86826b80434270b1f189e2"
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
