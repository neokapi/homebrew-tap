class KapiCli < Formula
  desc "AI-native localization framework — format-aware parsing, concurrent pipelines, and pluggable tools"
  homepage "https://github.com/neokapi/neokapi"
  version "1.0.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.0.1/kapi_1.0.1_darwin_arm64.tar.gz"
      sha256 "6de6321275cbe9b80ccfb80e3ff7967c0ec8ca6f60afd145e9da7acb9e77c7f1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.0.1/kapi_1.0.1_linux_arm64.tar.gz"
      sha256 "99d1826e3923902a1b44ea9855380211f52ebad2c5b4f214db417a590ca92f06"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.0.1/kapi_1.0.1_linux_amd64.tar.gz"
      sha256 "9900d91e32c2108e839668332600f0faddad1709076dc5e2dec4b05cbb79ca00"
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
