# vcekron/local

Personal Homebrew tap for two kinds of casks:

- **Tracked casks** that `homebrew/cask` disabled on 2026-09-01 because the apps are not signed/notarized (`fails_gatekeeper_check`). They are kept current automatically.
- **Frozen casks** pinned to one version.

## Casks

| Cask | Kind | Notes |
|------|------|-------|
| `aegisub` | tracked | Notarized since 3.5.0 (arm64 build), so no quarantine removal; still disabled in `homebrew/cask`. |
| `mumble` | tracked | Unsigned upstream. |
| `stolendata-mpv` | tracked | Unsigned upstream. Trimmed to the Apple Silicon / macOS 14+ build. |
| `syncplay` | tracked | Unsigned upstream. |
| `xld` | tracked | Unsigned upstream. |
| `vcekron-transmission-4-1-3` | frozen | Transmission 4.0.6 shipped a tracker-announce bug and was banned by many private trackers ([transmission#7083](https://github.com/transmission/transmission/issues/7083)). Pinned so a future bad release cannot arrive via `brew upgrade`. |

---

## Installation

```bash
brew tap vcekron/local
brew trust vcekron/local
brew install --cask vcekron/local/<cask>
```

Always use the fully-qualified name for the first install: tracked casks share their token with the disabled `homebrew/cask` originals. Homebrew records the tap a cask was installed from, so `brew upgrade` (and `brewup`) follow this tap afterwards.

To move an app installed from `homebrew/cask` to this tap:

```bash
brew uninstall --cask <cask>
brew install --cask vcekron/local/<cask>
```

---

## Tracked casks

Each file is a copy of the upstream `homebrew/cask` file with these changes:

- `disable!` removed.
- `auto_updates true` removed, so `brew outdated` reports new versions.
- For apps that are not notarized, a `postflight_steps` block that removes `com.apple.quarantine` from the installed app. **This bypasses Gatekeeper for that app**: macOS will not check its signature on first launch. Check with `spctl -a -vv /Applications/<App>.app`; if an app becomes notarized upstream, drop the block.
- If upstream changes its download file names, the bump fails and the cask's `url` needs a manual fix.

The upstream `livecheck` block is kept unchanged; it is how new versions are found.

**Automatic updates** (`.github/workflows/autobump.yml`) run daily at 05:17 UTC and on demand (Actions → autobump → Run workflow). For each cask that livecheck reports as outdated, the workflow runs `brew bump-cask-pr --write-only --commit`, audits the result with `brew audit --cask --strict --online`, and pushes passing bumps straight to `main`. A cask that fails to bump or audit is skipped and the run is marked failed, which triggers a GitHub email.

The new `sha256` is whatever upstream serves at bump time; there is no human review.

To check by hand: `brewup -l`, or `brew livecheck --tap vcekron/local`.

Adding a tracked cask: copy `brew cat --cask homebrew/cask/<cask>` into `Casks/<first-letter>/<cask>.rb`, apply the changes above, and run `brew style` and `brew audit --cask --strict --online` on it.

---

## Frozen casks

**Naming convention**

```
vcekron-<app>-<major>-<minor>-<patch>[-buildid]
```

The `vcekron-` prefix ensures frozen casks never shadow upstream casks like `transmission`, and the version in the token makes the pin explicit. Each has `livecheck do skip ... end` so the autobump workflow ignores it, and `auto_updates false`.

**In-app updaters**

`auto_updates false` only stops Homebrew from upgrading the app. Apps with a built-in updater (Transmission uses Sparkle) can still update themselves; turn off automatic update checks in the app's preferences to keep the pin.

**Bumping a frozen cask**

1) Rename the file so history follows it, and update the token inside:
```bash
git mv Casks/v/vcekron-transmission-4-1-3.rb Casks/v/vcekron-transmission-<x>-<y>-<z>.rb
```

2) Update `version` and `sha256`. Copy the rest from the current upstream cask (`brew cat --cask transmission`), keeping the skipped `livecheck` and `auto_updates false`.

3) Verify:
```bash
brew style --cask vcekron/local/<token>
brew audit --cask --strict --online vcekron/local/<token>
brew fetch --cask --force vcekron/local/<token>
```

4) Commit, push, and replace the installed version:
```bash
git commit -am "Bump frozen cask: <token>"
git push
brew uninstall --cask <old-token>
brew install --cask vcekron/local/<token>
```

**Switching back to upstream**

```bash
brew uninstall --cask vcekron-transmission-4-1-3
brew install --cask homebrew/cask/transmission
```

---

## Docs

- `brew help`, `man brew`
- Homebrew docs: https://docs.brew.sh/Taps , https://docs.brew.sh/Cask-Cookbook
