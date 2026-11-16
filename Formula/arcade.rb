# Prebuilt binaries rather than build-from-source: a from-source build needs the
# Rust toolchain and one exact Zig version, and Arcade publishes an archive for
# every target this formula supports.
class Arcade < Formula
  desc "Tmux-style terminal multiplexer"
  homepage "https://github.com/hong4rc/arcade"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/hong4rc/arcade/releases/download/v0.1.5/arcade-macos-apple-silicon.tar.gz"
      sha256 "7b0f4873456757f25f26471fe1addb04ca9ca6325726c0df09ea3b9723203b1d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/hong4rc/arcade/releases/download/v0.1.5/arcade-linux-arm64.tar.gz"
      sha256 "00bc96e5e5a6ec13c0c50fb50ae3b6a690ff6f12c29baaf7641aaf9fe01e09ea"
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
