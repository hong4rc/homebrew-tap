# Prebuilt binaries rather than build-from-source: a from-source build needs the
# Rust toolchain and one exact Zig version, and Arcade publishes an archive for
# every target this formula supports.
class Arcade < Formula
  desc "Tmux-style terminal multiplexer"
  homepage "https://github.com/hong4rc/arcade"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/hong4rc/arcade/releases/download/v0.1.4/arcade-macos-apple-silicon.tar.gz"
      sha256 "096dd95caddf294550218a74f333f458029eaba7342dbd130678ce351e91f83c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/hong4rc/arcade/releases/download/v0.1.4/arcade-linux-arm64.tar.gz"
      sha256 "12c1f47fdef4a7f145bdd058fea1baa3f16bf6dd07d72367e8261b68503e60d2"
    end
    on_intel do
      url "https://github.com/hong4rc/arcade/releases/download/v0.1.4/arcade-linux-amd64.tar.gz"
      sha256 "80323b04244bca5e29a97899e4f82f206519755c7ab2732ad9925549e8310203"
    end
  end

  def install
    bin.install "arcade"
  end

  def caveats
    <<~EOS
      Sessions live in a background process that keeps running across upgrades.
      After `brew upgrade`, run this once so the new version takes over (it ends
      the running sessions):
        arcade kill-server
    EOS
  end

  test do
    assert_equal "arcade #{version}", shell_output("#{bin}/arcade --version").strip
  end
end
