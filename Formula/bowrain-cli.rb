class BowrainCli < Formula
  desc "Bowrain plugin for kapi — sync .kapi projects with Bowrain Server"
  homepage "https://github.com/neokapi/neokapi"
  version "1.1.0"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-cli"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.1.0/kapi-bowrain_1.1.0_darwin_arm64.tar.gz"
      sha256 "7031f2458370068a99c4f73b73cc48239f3f4c35d355618d7f632ed1638aa339"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.1.0/kapi-bowrain_1.1.0_linux_arm64.tar.gz"
      sha256 "aaa73f283136e1ad2be02ba3b775eac67b226fcad2ef8de6e98304f3d18af4f3"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.1.0/kapi-bowrain_1.1.0_linux_amd64.tar.gz"
      sha256 "0ce0bd5863cf447bbf4ad5af971b5d916aed5bcdae2b4da2d17e47e2a62c633f"
    end
  end

  conflicts_with "bowrain-cli-beta", because: "both install the bowrain plugin"

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
