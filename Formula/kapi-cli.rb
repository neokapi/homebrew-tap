class KapiCli < Formula
  desc "AI-native localization framework — format-aware parsing, concurrent pipelines, and pluggable tools"
  homepage "https://github.com/neokapi/neokapi"
  version "1.0.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.0.2/kapi_1.0.2_darwin_arm64.tar.gz"
      sha256 "de2493229bfa5b1e3b7f4822fa09d8e4370e7a3d262f28cf645812e7380d96ac"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.0.2/kapi_1.0.2_linux_arm64.tar.gz"
      sha256 "c98b0a357d1fa251ad9ea6aa1e6b4dbfbc7bfcd871305e422722c0cc0776679b"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.0.2/kapi_1.0.2_linux_amd64.tar.gz"
      sha256 "7db71087d63f02b66ab937d17524af67a7f388ce539eeab28faff612bd617b92"
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
