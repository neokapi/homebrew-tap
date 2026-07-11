class KapiAv < Formula
  desc "Video-demux dependency plugin for kapi — bundles LGPL ffmpeg/ffprobe"
  homepage "https://github.com/neokapi/neokapi/tree/main/plugins/av"
  version "0.1.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/av-v0.1.0/kapi-av_0.1.0_darwin_arm64.tar.gz"
      sha256 "1b24b10e8042089faad51bcd93a7e7827d5e43fbb2dd4802076cee4fa10f5ae3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/av-v0.1.0/kapi-av_0.1.0_linux_arm64.tar.gz"
      sha256 "ae9ae54861f7458d731100ba7efc0245ebe0494eaec999a22ae5aca70bcd2b2d"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/av-v0.1.0/kapi-av_0.1.0_linux_amd64.tar.gz"
      sha256 "57b61c40635c75c0eda19a4cbeb9cf13f9de4be2c42f3d7259993ee0c35a2272"
    end
  end

  # Plugin layout: kapi-av binary + manifest.json + NOTICE + bundled LGPL ffmpeg
  # and ffprobe. Install the whole self-contained tree under the keg's own
  # share/kapi/plugins/av; Homebrew then links it to
  # HOMEBREW_PREFIX/share/kapi/plugins/av, the shared kapi plugins root the
  # in-process video demux (core/av) discovers. Installing into the keg (rather
  # than writing HOMEBREW_PREFIX directly) keeps the install sandbox-safe and lets
  # `brew uninstall` clean up. No depends_on kapi-cli — video is opt-in.
  def install
    (share/"kapi/plugins/av").install Dir["*"]
  end

  # Absorb macOS Gatekeeper's one-time first-exec assessment of the plugin
  # binary at install time instead of stalling kapi's first video demux.
  # Best-effort: a failure just means the first real exec pays it instead.
  def post_install
    system share/"kapi/plugins/av/kapi-av", "av"
  rescue
    nil
  end

  test do
    # The self-check prints the resolved ffmpeg/ffprobe paths and exits 0.
    assert_match "kapi-av",
      shell_output("#{share}/kapi/plugins/av/kapi-av av 2>&1")
  end
end
