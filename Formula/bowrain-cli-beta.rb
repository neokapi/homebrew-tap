class BowrainCliBeta < Formula
  desc "Bowrain plugin for kapi — sync .kapi projects with Bowrain Server"
  homepage "https://github.com/neokapi/neokapi"
  version "1.2.0-rc15"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-cli-beta"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/bowrain-v1.2.0-rc15/kapi-bowrain_1.2.0-rc15_darwin_arm64.tar.gz"
      sha256 "b9060c8eb5bdb377d68a00103c8db3e807c95f7fb36b72f9bd3309c8badf76b9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/bowrain-v1.2.0-rc15/kapi-bowrain_1.2.0-rc15_linux_arm64.tar.gz"
      sha256 "4a1fb8023e0b43e9cee9c8ecedc833777cb2d26913a741be1e75e7b1028a8a60"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/bowrain-v1.2.0-rc15/kapi-bowrain_1.2.0-rc15_linux_amd64.tar.gz"
      sha256 "70f2668f62e842bfa87a55cafe90c5d1cd5fee98cee841e432f48a2f66827d08"
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
  def post_install
    system share/"kapi/plugins/bowrain/kapi-bowrain", "version"
  rescue
    nil
  end

  test do
    # The plugin binary reports the version it was built at; this also proves the
    # tree actually landed in the shared kapi plugins root rather than being a
    # silently-empty install.
    assert_match version.to_s,
      shell_output("#{share}/kapi/plugins/bowrain/kapi-bowrain version 2>&1")
  end
end
