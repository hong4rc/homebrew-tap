# Prebuilt binaries rather than build-from-source: dpi-bypass publishes an archive for
# every target this formula supports. Installing through Homebrew also avoids the
# macOS "cannot verify it is free of malware" prompt, because brew downloads the
# archive without the quarantine flag that Gatekeeper checks.
class DpiBypass < Formula
  desc "Bypass DPI and SNI blocking (such as blocked Steam), no driver or admin"
  homepage "https://github.com/hong4rc/dpi-bypass"

  on_macos do
    on_arm do
      url "https://github.com/hong4rc/dpi-bypass/releases/download/v0.3.2/dpi-bypass-macos-apple-silicon.tar.gz"
      sha256 "04da5ba5ff1905774a8024c7abc4a6fd263a8a5a3bef3c59687673131722132e"
    end
    on_intel do
      url "https://github.com/hong4rc/dpi-bypass/releases/download/v0.3.2/dpi-bypass-macos-intel.tar.gz"
      sha256 "3fbd88910c641a96e7e0d2d1cf83c090a1fd2cd4ad5913b3c5c938302ab91a78"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/hong4rc/dpi-bypass/releases/download/v0.3.2/dpi-bypass-linux-amd64.tar.gz"
      sha256 "c602d3b1441a4e96c9fab2bc8ae61364218d0a0f4370e0fef7bad180be402354"
    end
  end

  def install
    bin.install "dpi-bypass"
    return unless OS.mac?

    # A small app bundle around the same binary, so it can be opened from Spotlight
    # or Launchpad like any app. LSUIElement keeps it out of the Dock: it lives in
    # the menu bar. Homebrew does not set the quarantine flag, so no Apple prompt.
    contents = prefix/"DPI Bypass.app/Contents"
    (contents/"MacOS").mkpath
    cp bin/"dpi-bypass", contents/"MacOS/dpi-bypass"
    (contents/"Info.plist").write <<~XML
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>CFBundleName</key><string>DPI Bypass</string>
        <key>CFBundleDisplayName</key><string>DPI Bypass</string>
        <key>CFBundleIdentifier</key><string>io.github.hong4rc.dpi-bypass</string>
        <key>CFBundleExecutable</key><string>dpi-bypass</string>
        <key>CFBundlePackageType</key><string>APPL</string>
        <key>CFBundleVersion</key><string>#{version}</string>
        <key>CFBundleShortVersionString</key><string>#{version}</string>
        <key>LSUIElement</key><true/>
      </dict>
      </plist>
    XML
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
      On macOS a dot appears in the menu bar: green when the bypass is on.

      Start it at every login (no terminal needed):
        brew services start dpi-bypass

      Or add it to Applications, then open it from Spotlight or Launchpad:
        ln -sf "#{opt_prefix}/DPI Bypass.app" /Applications/

      Or run `dpi-bypass` in a terminal.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dpi-bypass --version")
  end
end
