class KapiAsr < Formula
  desc "Speech-recognition plugin for kapi — transcribe audio/video via whisper.cpp"
  homepage "https://github.com/neokapi/neokapi/tree/main/plugins/asr"
  version "0.1.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/asr-v0.1.0/kapi-asr_0.1.0_darwin_arm64.tar.gz"
      sha256 "f2e726be8270e99d386e199558d916319f9e7f30671380bceed7eb497671afec"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/asr-v0.1.0/kapi-asr_0.1.0_linux_arm64.tar.gz"
      sha256 "05eb6a5e44e35637863c46470de92578cd2fb79503353b7d746b9b97f866ee09"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/asr-v0.1.0/kapi-asr_0.1.0_linux_amd64.tar.gz"
      sha256 "e3e7cdc533652c585a407194dc253cc405febabd983642288efa8c4b21ddfe31"
    end
  end

  # Plugin layout: kapi-asr binary + manifest.json + NOTICE + bundled whisper-cli
  # (+ its shared libs) + a default ggml-*.bin model. Install the whole
  # self-contained tree under the keg's own share/kapi/plugins/asr; Homebrew then
  # links it to HOMEBREW_PREFIX/share/kapi/plugins/asr, the shared kapi plugins
  # root `kapi` discovers. Installing into the keg (rather than writing
  # HOMEBREW_PREFIX directly) keeps the install sandbox-safe and lets
  # `brew uninstall` clean up. No depends_on kapi-cli — ASR is opt-in.
  def install
    (share/"kapi/plugins/asr").install Dir["*"]
  end

  test do
    # The self-check prints the resolved whisper-cli + model paths and exits 0;
    # this also exercises that the bundled whisper-cli resolves via @loader_path.
    assert_match "kapi-asr",
      shell_output("#{share}/kapi/plugins/asr/kapi-asr asr 2>&1")
  end
end
