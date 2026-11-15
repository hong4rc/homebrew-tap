# Prebuilt binaries rather than build-from-source: a from-source build needs the
# Rust toolchain and one exact Zig version, and Arcade publishes an archive for
# every target this formula supports.
class Arcade < Formula
  desc "Tmux-style terminal multiplexer"
  homepage "https://github.com/hong4rc/arcade"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/hong4rc/arcade/releases/download/v0.1.1/arcade-macos-apple-silicon.tar.gz"
      sha256 "57d12bfbdce201be0d2dde43c286a58cfd35617ba54a27890c023efaa4557a6e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/hong4rc/arcade/releases/download/v0.1.1/arcade-linux-arm64.tar.gz"
      sha256 "7fad04d7e2255c05a1884315d3c5640d28124699d94aa4c781c4f755a3038239"
    end
    on_intel do
      url "https://github.com/hong4rc/arcade/releases/download/v0.1.1/arcade-linux-amd64.tar.gz"
      sha256 "ad7f3b1e8c05c519ae2e2c2e5be23b1936c318c338cf558bf37f62c5ee7359bb"
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
