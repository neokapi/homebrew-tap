class KapiLlm < Formula
  desc "Local Gemma 4 LLM plugin for kapi — on-device text generation"
  homepage "https://github.com/neokapi/neokapi/tree/main/plugins/llm"
  version "0.1.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/llm-v0.1.0/kapi-llm_0.1.0_darwin_arm64.tar.gz"
      sha256 "fbaf8dba12afb821b3b2de89d10483d2b80cae55638e13035d2ee6ff56b9e0b1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/llm-v0.1.0/kapi-llm_0.1.0_linux_arm64.tar.gz"
      sha256 "3bd947fc88d573276d7451601236185136b21184a31df89e6398c74886309b2f"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/llm-v0.1.0/kapi-llm_0.1.0_linux_amd64.tar.gz"
      sha256 "0b9cc0e8684f7ead9303ce1b182c04447f5462d22f3f40d3ca34989d3dc24521"
    end
  end

  # Plugin layout: kapi-llm binary + manifest.json + lib/<bundled onnxruntime>.
  # The Gemma 4 model files are NOT bundled — they download on demand into an XDG
  # cache on first use, so the formula stays small. Install the whole
  # self-contained tree under the keg's own share/kapi/plugins/llm; Homebrew links
  # it to HOMEBREW_PREFIX/share/kapi/plugins/llm, the shared kapi plugins root
  # `kapi` discovers. No depends_on kapi-cli — the local LLM is opt-in, not
  # bundled with the CLI.
  def install
    (share/"kapi/plugins/llm").install Dir["*"]
  end

  test do
    # The self-check constructs the engine (loading the bundled onnxruntime via
    # the binary's rpath) and lists the supported models, then exits 0.
    assert_match "kapi-llm",
      shell_output("#{share}/kapi/plugins/llm/kapi-llm command llm 2>&1")
  end
end
