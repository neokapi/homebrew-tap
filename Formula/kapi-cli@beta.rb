class KapiCliATBeta < Formula
  desc "AI-native localization framework — format-aware parsing, concurrent pipelines, and pluggable tools"
  homepage "https://github.com/neokapi/neokapi"
  version "1.2.0-rc1"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-pdfium"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc1/kapi-cli_1.2.0-rc1_darwin_arm64.tar.gz"
      sha256 "2c93ce2bc7ac91d1a396e8ae018f1acc3d8b1271732665294d39fc345d02ac2d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc1/kapi-cli_1.2.0-rc1_linux_arm64.tar.gz"
      sha256 "783417e3fc6b81f3dc42f1d0fb8f26062b7a27d9fbebc7fb810d1a94c22d9a6b"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc1/kapi-cli_1.2.0-rc1_linux_amd64.tar.gz"
      sha256 "ea2f9c12667f7d1524a3c8808d52f452357b74c0cc2ce66275829811b1851a52"
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
