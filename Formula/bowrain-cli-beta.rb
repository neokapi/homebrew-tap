class BowrainCliBeta < Formula
  desc "Bowrain plugin for kapi — sync .kapi projects with Bowrain Server"
  homepage "https://github.com/neokapi/neokapi"
  version "1.3.0-rc4"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-cli-beta"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/bowrain-v1.3.0-rc4/kapi-bowrain_1.3.0-rc4_darwin_arm64.tar.gz"
      sha256 "7dc2ad866f31d3287e72b271ceb2bae13dd11d85888245e49872ec3e8b04e6cd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/bowrain-v1.3.0-rc4/kapi-bowrain_1.3.0-rc4_linux_arm64.tar.gz"
      sha256 "ab746ac688a162cdd96a25e4644e6b2d5562651977de56fead7882844e79478c"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/bowrain-v1.3.0-rc4/kapi-bowrain_1.3.0-rc4_linux_amd64.tar.gz"
      sha256 "9cc96fe80b3bf7812dec4aa3029015ea397bc1fdbac804331250c032689c6431"
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
