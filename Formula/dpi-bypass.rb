# Prebuilt binaries rather than build-from-source: dpi-bypass publishes an archive for
# every target this formula supports. Installing through Homebrew also avoids the
# macOS "cannot verify it is free of malware" prompt, because brew downloads the
# archive without the quarantine flag that Gatekeeper checks.
class DpiBypass < Formula
  desc "Bypass DPI and SNI blocking (such as blocked Steam), no driver or admin"
  homepage "https://github.com/hong4rc/dpi-bypass"

  on_macos do
    on_arm do
      url "https://github.com/hong4rc/dpi-bypass/releases/download/v0.3.1/dpi-bypass-macos-apple-silicon.tar.gz"
      sha256 "eb10286456b5ed5ad6a89b02d44991d1ba9a1f974566b15d6c704a1a2f20b45b"
    end
    on_intel do
      url "https://github.com/hong4rc/dpi-bypass/releases/download/v0.3.1/dpi-bypass-macos-intel.tar.gz"
      sha256 "e9a73c502462b376424823f7eff0b81d44d23af5e398feea3c1271e223c18b92"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/hong4rc/dpi-bypass/releases/download/v0.3.1/dpi-bypass-linux-amd64.tar.gz"
      sha256 "7b6a93e1bb1164b1762417d1373e35b69b6bdeb2b76c076474e36eaf8fee26b7"
    end
  end

  def install
    bin.install "dpi-bypass"
  end

  # `brew services start dpi-bypass` runs it at login. On macOS the menu bar icon
  # appears from that background run; Quit in the menu stops it until the next login.
  service do
    run [opt_bin/"dpi-bypass"]
    keep_alive crashed: true
    log_path var/"log/dpi-bypass.log"
    error_log_path var/"log/dpi-bypass.log"
  end

  def caveats
    <<~EOS
      Run `dpi-bypass` in a terminal to start it, or start it at every login with:
        brew services start dpi-bypass
      On macOS a dot appears in the menu bar: green when the bypass is on.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dpi-bypass --version")
  end
end
