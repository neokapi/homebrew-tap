class BowrainCliBeta < Formula
  desc "Bowrain plugin for kapi — sync .kapi projects with Bowrain Server"
  homepage "https://github.com/neokapi/neokapi"
  version "1.2.0-rc16"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-cli-beta"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/bowrain-v1.2.0-rc16/kapi-bowrain_1.2.0-rc16_darwin_arm64.tar.gz"
      sha256 "489d1b17c0ee2354bfb18d132a79e09b6cf7a650ec184eddbda4c8285bfadd44"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/bowrain-v1.2.0-rc16/kapi-bowrain_1.2.0-rc16_linux_arm64.tar.gz"
      sha256 "f84b7b2ccb2a9955c1fa4bd7421d9557ffaa6b3f743e00bcd16a7de2a7309746"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/bowrain-v1.2.0-rc16/kapi-bowrain_1.2.0-rc16_linux_amd64.tar.gz"
      sha256 "f90f86e28e0798f590724fd1c2c74d5ec61c1ed1352ad27dc5deabd55e5607d5"
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
