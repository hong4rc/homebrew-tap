# Prebuilt binaries rather than build-from-source: a from-source build needs the
# Rust toolchain and one exact Zig version, and Arcade publishes an archive for
# every target this formula supports.
class Arcade < Formula
  desc "Tmux-style terminal multiplexer"
  homepage "https://github.com/hong4rc/arcade"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/hong4rc/arcade/releases/download/v0.1.0/arcade-macos-apple-silicon.tar.gz"
      sha256 "21e7b095392cfa6357ee6b706b2bea52b3d57550ec747b7b31b8e3ce8f81f338"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/hong4rc/arcade/releases/download/v0.1.0/arcade-linux-arm64.tar.gz"
      sha256 "87e7657338f6a33491d5864af23e9185c9ba5807831ccd68d3445310eef99c85"
    end
    on_intel do
      url "https://github.com/hong4rc/arcade/releases/download/v0.1.0/arcade-linux-amd64.tar.gz"
      sha256 "0b4669092096b5f32a2128da5444e4f981638e57285fa02ac250b487852db106"
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
