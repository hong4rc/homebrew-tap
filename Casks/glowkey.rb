cask "glowkey" do
  version "0.1.0"
  sha256 "f8097638cef26376ea3b9760225e9bf5cd4b163d4e9f1d5fc2ea3eb2a9cc9dbe"

  url "https://github.com/hong4rc/glowkey/releases/download/v#{version}/GlowKey-#{version}.dmg"
  name "GlowKey"
  desc "Vietnamese input method in the style of UniKey"
  homepage "https://github.com/hong4rc/glowkey"

  # 13.0 is what the bundle declares (LSMinimumSystemVersion), not a guess.
  # A bare symbol, not the string form: `">= :ventura"` is deprecated and warns
  # on every install, and omitting the stanza entirely fails `brew audit`.
  depends_on macos: :ventura

  app "GlowKey.app"

  # GlowKey is a background agent holding a CGEventTap. Replacing the bundle
  # underneath a running tap leaves two taps processing every keystroke, so quit
  # it before upgrading or uninstalling rather than after.
  uninstall quit: "io.glowkey.GlowKey"

  # Paths read from settings_store.rs and log.rs, not assumed.
  zap trash: [
    "~/Library/Application Support/GlowKey",
    "~/Library/Logs/GlowKey",
  ]

  caveats <<~EOS
    GlowKey is signed ad-hoc rather than notarized, so macOS will refuse to open
    it until you clear the quarantine flag once:

      xattr -dr com.apple.quarantine /Applications/GlowKey.app

    It then needs Accessibility permission (System Settings > Privacy & Security
    > Accessibility) to wrap your keyboard layout. The app asks on first launch.

    That grant is keyed to the code signature, so a future `brew upgrade` will
    drop it and you will be asked again.
  EOS
end
