# vcekron/local

Private Homebrew tap for:
- Custom formulae
- Version‑locked (“frozen”) casks for rollback/testing

---

## Installation

Install directly by fully qualifying the tap:

```bash
brew install --cask vcekron/local/<cask-or-formula>
```

Or tap it first:

```bash
brew tap vcekron/local
brew install --cask <cask-or-formula>
brew install <formula>
```

**Brewfile** example:

```ruby
tap "vcekron/local"

# formulae
brew "my-formula"

# frozen casks
cask "vcekron-chatgpt-1-2025-210"
```

---

## Frozen casks (version‑locked)

**Naming convention**

```
vcekron-<app>-<major>-<minor>-<patch>[-buildid]
```

Examples
- Frozen: `vcekron-chatgpt-1-2025-210`
- With build id: `vcekron-chatgpt-1-2025-210-1754404853`

This ensures frozen casks never shadow upstream casks like `chatgpt`.

**Usage**

Install the frozen version from this tap:
```bash
brew install --cask vcekron/local/vcekron-chatgpt-1-2025-210
```

Install/upgrade the latest official (from homebrew/cask):
```bash
brew install --cask chatgpt
# or explicitly:
brew install --cask homebrew/cask/chatgpt
```

---

## Adding a new frozen cask (quick guide)

1) Create a unique token & file:
```bash
mkdir -p Casks/<first-letter>
$EDITOR Casks/<first-letter>/<token>.rb
```
Example
```
token: vcekron-chatgpt-1-2025-210
file:  Casks/v/vcekron-chatgpt-1-2025-210.rb
```

2) Set `version`, `sha256`, and a fixed `url`. Prefer `auto_updates false` and a `livecheck` block that’s skipped.

3) Commit & push:
```bash
git add Casks/...rb
git commit -m "Add frozen cask: <token>"
git push
brew update
```

---

## Avoiding shadowing

- Use unique tokens for frozen casks (as above).
- When you want to be explicit, fully qualify upstream:
```bash
brew reinstall --cask homebrew/cask/chatgpt
```

---

## Docs

- `brew help`, `man brew`
- Homebrew docs: https://docs.brew.sh/Taps , https://docs.brew.sh/Cask-Cookbook
