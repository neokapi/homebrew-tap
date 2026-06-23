class KapiCliATBeta < Formula
  desc "AI-native localization framework — format-aware parsing, concurrent pipelines, and pluggable tools"
  homepage "https://github.com/neokapi/neokapi"
  version "1.2.0-rc1"
  license "Apache-2.0"

  depends_on "neokapi/tap/kapi-pdfium"

  on_macos do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc1/kapi-cli_1.2.0-rc1_darwin_arm64.tar.gz"
      sha256 "6c6cdfc5733153aff7396b60b73078e9ad3387ed74b6b1059e234cddce0eb4a8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc1/kapi-cli_1.2.0-rc1_linux_arm64.tar.gz"
      sha256 "789bb4b9d1b5f2fc31037f3f61d5e31175c3fe717c3ddcd86a97cd2af6f866c2"
    end
    on_intel do
      url "https://github.com/neokapi/neokapi/releases/download/v1.2.0-rc1/kapi-cli_1.2.0-rc1_linux_amd64.tar.gz"
      sha256 "c7bc465a85da9c25cb2ee746e87b2f42874d29740a377bb975c43c287a3cb622"
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
