# devbox

Sets up my Mac: apps and CLI tools, runtimes, shell and git config, and macOS preferences.

| File | What it does |
|---|---|
| `Brewfile` | CLI tools and apps, installed with `brew bundle` |
| `home/` | Config files, applied to `~` by [chezmoi](https://www.chezmoi.io) |
| `home/dot_config/mise/config.toml` | Default Node, Python, Go, Bun and uv versions ([mise](https://mise.jdx.dev)) |
| `macos.sh` | Finder, Dock and trackpad preferences |
| `bootstrap.sh` | Runs everything above. Safe to re-run. |

## New Mac

```sh
xcode-select --install          # wait for it to finish
git clone https://github.com/ok2ju/devbox.git ~/Projects/personal/devbox
~/Projects/personal/devbox/bootstrap.sh
```

Then, by hand:

1. Sign in to your Apple ID and turn on FileVault.
2. Create `~/.gitconfig-local` for anything that must stay out of this repo, such as the work git identity.
3. Create a new SSH key: `ssh-keygen -t ed25519`. Never copy keys from the old machine.
4. Run `colima start` before you use `docker`.
5. Grant app permissions (Accessibility, Screen Recording for Kap) when macOS asks.

## Day to day

- New tool: add it to `Brewfile`, then run `brew bundle`.
- Changed a config file in `~`: run `chezmoi re-add`, then commit.
- Changed a file in `home/`: run `chezmoi diff`, then `chezmoi apply`.

## Rules

This repo is public. Never commit tokens, keys, internal hostnames or work config. The pre-commit hook runs `gitleaks` on every commit. Put machine-specific or private values in `~/.gitconfig-local` or other untracked files.
