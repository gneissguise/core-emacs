# core-emacs — Minimal, modular Emacs configuration

A small, fast, and modular Emacs configuration focused on keeping Emacs "core-like" while providing sensible enhancements. Intended to be installed in your XDG config directory (e.g. `~/.config/emacs`) and used with Emacs 29 or newer.

This repository aims to be lean and easily auditable — it prefers tiny, well-documented modules under `lisp/` and keeps heavier or machine-specific artifacts out of version control.

---

## Features

- Modular configuration split into small files under `lisp/` (UI, packages, editing, programming, org, etc.)
- Fast startup optimizations placed in `early-init.el`
- Minimal opinionated defaults (user info, editing prefs, recentf, backups)
- Local vendor code support via `local/` (example: `combobulate`)

---

## Requirements

- Emacs 29 or newer (configured and tested against Emacs 29+ features)
- Git (for cloning the config)

Optional (recommended):

- A modern terminal or GUI for best UI experience
- `git` to track your personal changes

---

## Installation

Clone this repository into your XDG config directory so Emacs will load it automatically:

```bash
# If you use XDG config directory (recommended)
git clone git@github.com:gneissguise/core-emacs.git ~/.config/emacs

# Or clone to ~/.emacs.d if you prefer the legacy location
git clone git@github.com:gneissguise/core-emacs.git ~/.emacs.d
```

After cloning, start Emacs. The config uses `early-init.el` for early startup optimizations and `init.el` as the main entrypoint.

Note: Package management and third-party packages are installed into `elpa/` by default (this directory is ignored by `.gitignore`). If you want to vendor packages, add them under `local/` and track them in Git.

---

## Layout

Top-level files you care about:

- `early-init.el` — Very early startup settings (GC tuning, UI disabling)
- `init.el` — Main entrypoint, loads essential modules and defers the rest
- `custom.el` — (ignored) Emacs' customization file; excluded from VCS
- `lisp/` — Modular configuration files (core-*.el)
- `local/` — Local vendor or third-party packages (e.g. `combobulate`)

The `lisp/` directory contains small, focused modules such as:

- `core-packages.el` — package setup and package list
- `core-environment.el` — environment-related tweaks
- `core-ui.el` — UI tweaks
- `core-completion.el`, `core-editing.el`, `core-programming.el`, etc.

---

## Customization

- Keep machine/user-specific secrets or settings out of the repo. `custom.el` is ignored — use it or create `custom.local.el` and add it to your `~/.config/emacs/custom.el` if you want local-only overrides.
- To add personal snippets or local packages, place them under `local/` and track them if you want them versioned.
- To change user metadata, edit `user-full-name` and `user-mail-address` in `init.el` or set them in your `custom.el`.

---

## Package management

This config uses the bundled package manager (ELPA/MELPA) and installs packages into `elpa/` by default. Because `elpa/` is ignored, package artifacts aren't checked into Git. If you want reproducible setups across machines, consider one of:

- Recording pinned package versions in a small bootstrap file
- Using `straight.el` or `package-jnk` vendoring for deterministic installs
- Vendoring packages into `local/` and tracking them in Git

---

## Troubleshooting

- If Emacs fails to start after a change, start Emacs with `--debug-init` to see backtraces.
- You can start Emacs with `emacs -q -l ~/.config/emacs/init.el` to skip other system configs and load only this one.
- If packages are missing, run `M-x package-refresh-contents` then `M-x package-install` for the required packages, or restart Emacs to trigger package bootstrap.
