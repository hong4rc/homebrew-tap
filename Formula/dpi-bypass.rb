# Prebuilt binaries rather than build-from-source: dpi-bypass publishes an archive for
# every target this formula supports. Installing through Homebrew also avoids the
# macOS "cannot verify it is free of malware" prompt, because brew downloads the
# archive without the quarantine flag that Gatekeeper checks.
class DpiBypass < Formula
  desc "Bypass DPI and SNI blocking (such as blocked Steam), no driver or admin"
  homepage "https://github.com/hong4rc/dpi-bypass"
  version "0.3.0"

  on_macos do
    on_arm do
      url "https://github.com/hong4rc/dpi-bypass/releases/download/v0.3.0/dpi-bypass-macos-apple-silicon.tar.gz"
      sha256 "28745cb0d7c7757ab43a87f66f0d70dfa2e9f8ed142a33f07d15267ae8199d39"
    end
    on_intel do
      url "https://github.com/hong4rc/dpi-bypass/releases/download/v0.3.0/dpi-bypass-macos-intel.tar.gz"
      sha256 "78061f115aedbd46701a62f2c09835796767da4b2b446d761b9c7e40d92540fc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/hong4rc/dpi-bypass/releases/download/v0.3.0/dpi-bypass-linux-amd64.tar.gz"
      sha256 "5e403f93723b3d88782adab2abdf8eb8809abe2422f9d90882b5a385299c9b9e"
    end
  end

  def install
    bin.install "dpi-bypass"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dpi-bypass --version")
  end
end
