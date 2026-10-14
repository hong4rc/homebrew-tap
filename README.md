# hong4rc/homebrew-tap

Homebrew formulae and casks for [hong4rc](https://github.com/hong4rc) projects.

```sh
brew tap hong4rc/tap
```

`hong4rc/tap` is the short form Homebrew expands to this repository — the
`homebrew-` prefix in the repository name is a convention, not something you type.

## What is here

| Install | What it is |
|---|---|
| `brew install hong4rc/tap/git-vanity` | Generate Git commit hashes matching a custom hex pattern — make a commit start with `cafe`, `dead`, `c0ffee`. |
| `brew install --cask hong4rc/tap/glowkey` | A Vietnamese input method for macOS, in the style of UniKey. Telex, VNI and Simple Telex, a per-app ignore list, macros. |
| `brew install hong4rc/tap/dpi-bypass` | Bypass DPI / SNI blocking (for example blocked Steam) with no driver and no admin rights. Installing through Homebrew avoids the macOS "cannot verify" prompt. Run `dpi-bypass` in a terminal. |

## GlowKey needs two extra steps

**It is not notarized.** GlowKey is signed ad-hoc, deliberately — notarization
requires a paid Apple Developer account, and the project chose not to buy one
(`docs/decisions/0006` in the GlowKey repository). macOS will therefore refuse to
open it until you clear the quarantine flag once:

```sh
xattr -dr com.apple.quarantine /Applications/GlowKey.app
```

**It needs Accessibility permission.** GlowKey installs a `CGEventTap` to wrap
your keyboard layout, which macOS gates behind
System Settings → Privacy & Security → Accessibility. The app asks for this on
first launch and waits until you grant it.

Note that the grant is keyed to the code signature, so **a `brew upgrade` will
drop it** and you will be asked again. That is a consequence of ad-hoc signing,
not a bug.

## Contributing

These are personal projects. Issues belong on the project repositories, not here;
this tap only carries the install recipes.
