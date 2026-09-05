# Prebuilt binaries rather than build-from-source: git-vanity publishes them for
# every target this formula supports, and a from-source build would pull the
# whole Rust toolchain onto a machine that only wants one small tool.
class GitVanity < Formula
  desc "Generate Git commit hashes matching custom patterns"
  homepage "https://github.com/hong4rc/git-vanity"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/hong4rc/git-vanity/releases/download/v0.1.0/git-vanity-aarch64-apple-darwin"
      sha256 "42470263baeb46dd5fc0969ed223e15ff042affeaa5a6c35001d40c7e64c8ebb"
    end
    on_intel do
      url "https://github.com/hong4rc/git-vanity/releases/download/v0.1.0/git-vanity-x86_64-apple-darwin"
      sha256 "e2eba7f7d9f7a3e29bbaf47935b9f06e065c4f52d1377bd3de431d42bd0e0569"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/hong4rc/git-vanity/releases/download/v0.1.0/git-vanity-aarch64-unknown-linux-gnu"
      sha256 "8da05b83195d4b9c6e3b67b92cabb9d61c1a0e4d4ba7c89f0eda843eb02a16ac"
    end
    on_intel do
      url "https://github.com/hong4rc/git-vanity/releases/download/v0.1.0/git-vanity-x86_64-unknown-linux-gnu"
      sha256 "75ff607b686ebd09fe9376e8098c690977b1dbc36f972769e93486dd1a918ebf"
    end
  end

  def install
    # The release assets are bare binaries named per target, so rename on install.
    bin.install Dir["git-vanity-*"].first => "git-vanity"
  end

  test do
    assert_match "git-vanity", shell_output("#{bin}/git-vanity --help 2>&1")
  end
end
