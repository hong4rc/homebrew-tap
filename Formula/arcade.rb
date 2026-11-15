# Prebuilt binaries rather than build-from-source: a from-source build needs the
# Rust toolchain and one exact Zig version, and Arcade publishes an archive for
# every target this formula supports.
class Arcade < Formula
  desc "Tmux-style terminal multiplexer"
  homepage "https://github.com/hong4rc/arcade"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/hong4rc/arcade/releases/download/v0.1.3/arcade-macos-apple-silicon.tar.gz"
      sha256 "40c91928b2103c1df55fd1ffa3363f64486af20ac287138f59a9574f1caa4852"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/hong4rc/arcade/releases/download/v0.1.3/arcade-linux-arm64.tar.gz"
      sha256 "6e79767a9e7a2b69877c13aed4ba907002a3b106fc159c3d133945d6a62c4527"
    end
    on_intel do
      url "https://github.com/hong4rc/arcade/releases/download/v0.1.3/arcade-linux-amd64.tar.gz"
      sha256 "0250ec7f9580a5d0dea825e803b5c50fddce70619aa7115b9b41367b35a3fa6e"
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
