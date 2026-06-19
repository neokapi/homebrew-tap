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
  # and ffprobe. Install the whole self-contained tree into pkgshare and symlink
  # it into the shared kapi plugins root so the in-process video demux (core/av)
  # discovers the bundled binaries (no depends_on kapi-cli — video is opt-in).
  def install
    plugin_dir = pkgshare/"plugins/av"
    plugin_dir.install Dir["*"]
    kapi_share = HOMEBREW_PREFIX/"share/kapi/plugins"
    kapi_share.mkpath
    ln_sf plugin_dir, kapi_share/"av"
  end

  test do
    # The self-check prints the resolved ffmpeg/ffprobe paths and exits 0.
    assert_match "kapi-av",
      shell_output("#{HOMEBREW_PREFIX}/share/kapi/plugins/av/kapi-av av 2>&1")
  end
end
