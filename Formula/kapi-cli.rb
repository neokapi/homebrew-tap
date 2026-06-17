class KapiCli < Formula
  desc "AI-native localization framework — format-aware parsing, concurrent pipelines, and pluggable tools"
  homepage "https://github.com/neokapi/neokapi"
  version "1.1.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.1.0/kapi_1.1.0_darwin_arm64.tar.gz"
      sha256 "6c1e44167fcf918582a13a19e8b127637d075b24f6b9e967af360851c3331081"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.1.0/kapi_1.1.0_linux_arm64.tar.gz"
      sha256 "89b900d6b4a93ccbba7c0e5a1f89e0b641bd2e1ee661cf2c2b534be5fd893744"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.1.0/kapi_1.1.0_linux_amd64.tar.gz"
      sha256 "7ca2c949a723d88976b445051287d81cc91c9f491418824fe53755b0ecd0a1f1"
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
