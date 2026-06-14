class KapiCli < Formula
  desc "AI-native localization framework — format-aware parsing, concurrent pipelines, and pluggable tools"
  homepage "https://github.com/neokapi/neokapi"
  version "1.0.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.0.0/kapi_1.0.0_darwin_arm64.tar.gz"
      sha256 "0178a0631ce341d7c21bb83630c5818f1523dcb377146b1c8943ed3eb5791073"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.0.0/kapi_1.0.0_linux_arm64.tar.gz"
      sha256 "77323c711631c5facda64820db7b8b0f0bd9862ce2648b8db380c3379c606ef3"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.0.0/kapi_1.0.0_linux_amd64.tar.gz"
      sha256 "f58a2816adddf65ac073262ba60a22bbe62650293e7494de7ca982f2babfcca5"
    end
  end

  # Install kapi plus its multi-call toolbox aliases. kgrep / ksed / kcat / kconv
  # are symlinks to the kapi binary, which dispatches on its invocation name
  # (busybox-style) — no extra binaries, no extra download size.
  def install
    bin.install "kapi"
    bin.install_symlink bin/"kapi" => "kgrep"
    bin.install_symlink bin/"kapi" => "ksed"
    bin.install_symlink bin/"kapi" => "kcat"
    bin.install_symlink bin/"kapi" => "kconv"
  end

  test do
    system "#{bin}/kapi", "version"
    assert_match "grep", shell_output("#{bin}/kgrep --help 2>&1")
  end
end
