# Prebuilt binaries rather than build-from-source: dpi-bypass publishes an archive for
# every target this formula supports. Installing through Homebrew also avoids the
# macOS "cannot verify it is free of malware" prompt, because brew downloads the
# archive without the quarantine flag that Gatekeeper checks.
class DpiBypass < Formula
  desc "Bypass DPI and SNI blocking (such as blocked Steam), no driver or admin"
  homepage "https://github.com/hong4rc/dpi-bypass"

  on_macos do
    on_arm do
      url "https://github.com/hong4rc/dpi-bypass/releases/download/v0.3.3/dpi-bypass-macos-apple-silicon.tar.gz"
      sha256 "d23e7b45978836b604f47301034fd258879c5056959fc0f1122130916b3fa1b9"
    end
    on_intel do
      url "https://github.com/hong4rc/dpi-bypass/releases/download/v0.3.3/dpi-bypass-macos-intel.tar.gz"
      sha256 "64a11d42e14e420ad0f6d79aed29bac12613a0a5323d8072c09dab0ecae4edd2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/hong4rc/dpi-bypass/releases/download/v0.3.3/dpi-bypass-linux-amd64.tar.gz"
      sha256 "e42c404481aef90367fd88bc3d891df4025e31a9e8217d94763bbe2d6bf886f4"
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
