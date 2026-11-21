# Prebuilt binaries rather than build-from-source: a from-source build needs the
# Rust toolchain and one exact Zig version, and Arcade publishes an archive for
# every target this formula supports.
class Arcade < Formula
  desc "Tmux-style terminal multiplexer"
  homepage "https://github.com/hong4rc/arcade"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/hong4rc/arcade/releases/download/v0.1.6/arcade-macos-apple-silicon.tar.gz"
      sha256 "49462bb39551a75650fb0d9931fa42b269eb944aaef8a91b34217ce01d0dc707"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/hong4rc/arcade/releases/download/v0.1.6/arcade-linux-arm64.tar.gz"
      sha256 "18953bfb1fddb9b55bccbd116372175b33ad1ef6f47eafc052a845d95f6b9c5e"
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
      After `brew upgrade`, run this so the new version takes over and the
      sessions keep running:
        arcade upgrade
      A background process from 0.1.3 or 0.1.4 cannot do that: move it once with
      (this ends the programs running in its panes; run it outside Arcade)
        arcade upgrade --restart
    EOS
  end

  test do
    assert_equal "arcade #{version}", shell_output("#{bin}/arcade --version").strip
  end
end
