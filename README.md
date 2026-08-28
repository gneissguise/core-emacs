# core-emacs - Minimal, modular Emacs configuration

A small, fast, and modular Emacs configuration focused on keeping Emacs "core-like" while providing sensible enhancements. Intended to be installed in your XDG config directory (e.g. `~/.config/emacs`) and used with Emacs 31.1 or newer.

This repository aims to be lean and easily auditable - it prefers tiny, well-documented modules under `lisp/` and keeps heavier or machine-specific artifacts out of version control.

---

## Features

- Modular configuration split into small files under `lisp/` (UI, packages, editing, programming, org, etc.)
- Fast startup optimizations placed in `early-init.el`
- Minimal opinionated defaults (user info, editing prefs, recentf, backups)
- Emacs 31.1 native features: `vc-auto-revert-mode` for lightweight version control tracking, `mode-line-collapse-minor-modes` for cleaner mode-line display
- Third-party packages in `site-lisp/combobulate/` (git submodule; only this subdirectory is added to load-path) and `elpa/` (auto-managed by package manager)
- Structural editing with [combobulate](https://github.com/mickeynp/combobulate) (Tree-sitter powered, installed to `site-lisp/`)
- Deferred configuration loading via `emacs-startup-hook` for snappy startup

---

## Requirements

- Emacs 31.1 or newer (configured and tested against Emacs 31.1+ features)
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

Install [combobulate](https://github.com/mickeynp/combobulate) (Tree-sitter structural editing):

```bash
cd ~/.config/emacs
git clone --depth 1 https://github.com/mickeynp/combobulate.git site-lisp/combobulate
```

Then start Emacs. The config uses `early-init.el` for early startup optimizations and `init.el` as the main entrypoint.

Note: Package management and third-party packages are installed into `elpa/` by default (this directory is ignored by `.gitignore`). If you want to vendor packages, add them under `site-lisp/` and add the path to `load-path` in your configuration.

---

## Layout

Top-level files you care about:

- `early-init.el` - Very early startup settings (GC tuning, UI disabling)
- `init.el` - Main entrypoint, loads essential modules and defers the rest
- `custom.el` - (ignored) Emacs' customization file; excluded from VCS
- `lisp/` - Modular configuration files (core-*.el)
- `user-lisp/` - (optional) Emacs 31+ User Lisp Directory for personal snippets; not used by this config
- `site-lisp/` - Manually cloned third-party packages (e.g. combobulate for Tree-sitter structural editing)

The `lisp/` directory contains small, focused modules such as:

- `core-packages.el` - package setup and package list
- `core-environment.el` - environment-related tweaks
- `core-ui.el` - UI tweaks
- `core-completion.el`, `core-editing.el`, `core-programming.el`, etc.

---

## Customization

- Keep machine/user-specific secrets or settings out of the repo. `custom.el` is ignored - use it for local-only overrides, or create a separate `custom.local.el` and load it from your `custom.el` with `(load "custom.local" t t)`.
- To add personal snippets or local packages, place them under `user-lisp/`. Emacs 31+ auto-discovers this directory, adds it to the load path, byte-compiles it, and scrapes autoloads - no manual configuration needed.
- For manually cloned third-party packages that aren't available on MELPA (e.g. combobulate), place them under `site-lisp/`. Only specific subdirectories (such as `site-lisp/combobulate`) are added to `load-path` in the configuration - not the entire `site-lisp/` directory.
- To change user metadata, edit `user-full-name` and `user-mail-address` in `init.el` or set them in your `custom.el`.

---

## Package management

This config uses the bundled package manager (ELPA/MELPA) and installs packages into `elpa/` by default. Because `elpa/` is ignored, package artifacts aren't checked into Git. If you want reproducible setups across machines, consider one of:

- Recording pinned package versions in a small bootstrap file
- Using `straight.el` or `package-jnk` vendoring for deterministic installs
- Cloning third-party packages into `site-lisp/` and tracking them in Git (requires manual load-path setup in configuration)

Note: Some packages that were once third-party (e.g. `eglot`, `aggressive-indent`) are now built-in to modern Emacs, reducing external dependencies.

---

## Troubleshooting

- If Emacs fails to start after a change, start Emacs with `--debug-init` to see backtraces.
- You can start Emacs with `emacs -q -l ~/.config/emacs/init.el` to skip other system configs and load only this one.
- If packages are missing, run `M-x package-refresh-contents` then `M-x package-install` for the required packages, or restart Emacs to trigger package bootstrap.
