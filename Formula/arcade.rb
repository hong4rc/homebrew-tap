# Prebuilt binaries rather than build-from-source: a from-source build needs the
# Rust toolchain and one exact Zig version, and Arcade publishes an archive for
# every target this formula supports.
class Arcade < Formula
  desc "Tmux-style terminal multiplexer"
  homepage "https://github.com/hong4rc/arcade"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/hong4rc/arcade/releases/download/v0.1.2/arcade-macos-apple-silicon.tar.gz"
      sha256 "9b41fef4e0825b896d1f6afefe06cc18ecd353f42c998abae6855aaefa704ee5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/hong4rc/arcade/releases/download/v0.1.2/arcade-linux-arm64.tar.gz"
      sha256 "0e6a8ef4a7ae4b054795227a130a2045491089e4e685fd1b5d7e5b6a85b4e491"
    end
    on_intel do
      url "https://github.com/hong4rc/arcade/releases/download/v0.1.2/arcade-linux-amd64.tar.gz"
      sha256 "e2b74864e91dc31ecf5bd9759c60cc40cf7a8b3ebfa8b344a8f320201d6bb4b2"
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
