# Alias does dotfiles

My shell, git and app settings, plus the tools I use every day.

- [chezmoi](https://www.chezmoi.io) installs the files and fills in
  machine-specific values, such as name and email.
- [mise](https://mise.jdx.dev) installs and pins tool versions.
- [Homebrew](https://brew.sh) installs the apps.

## Install

**Before you start (macOS):** give your terminal Full Disk Access in System
Settings → Privacy & Security → Full Disk Access, then quit and reopen it. The
setup changes Safari settings, and macOS only allows that with Full Disk Access.

**Fresh machine** (no clone needed):

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init alias-mac --apply
```

**From the repo:**

```sh
git clone git@github.com:alias-mac/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./setup
```

This will install chezmoi (if needed), apply your dotfiles, install
[Homebrew](https://brew.sh) packages, set up mise tools, and configure macOS
preferences. Chezmoi will prompt for your name, email, and work email on first
run.

The main file you'll want to change right off the bat is `.chezmoi.toml.tmpl`,
which controls the template variables for your particular machine. You can also
use `~/.localrc` for machine-specific overrides that shouldn't be versioned.

## Components

There's a few special files in the hierarchy.

- **bin/**: Scripts in `bin/` are installed to `~/bin`, which is on your
  `$PATH`. Name them `executable_<name>` so chezmoi marks them executable (e.g.,
  `bin/executable_git-up` becomes `~/bin/git-up`).
- **dot_Brewfile.tmpl**: This is a list of packages and applications for
  [Homebrew](https://brew.sh) to install: things like git, coreutils, or
  applications like iTerm2, Raycast and VSCode. On macOS it becomes
  `~/.Brewfile`, and `brew bundle` runs whenever it changes. Might want to edit
  this file before running any initial setup.
- **dot\_\***: Files managed by chezmoi, placed in your `$HOME` (e.g.,
  `dot_zshrc` becomes `~/.zshrc`).
- **dot\_\*.tmpl**: Templated files — chezmoi substitutes variables like name,
  email, and OS.
- **.chezmoiscripts/**: Scripts that run automatically during `chezmoi apply`
  (Homebrew, mise install, macOS preferences).
- **.chezmoiexternals/**: External dependencies managed by chezmoi (zsh plugins,
  mise binary).

## Bugs

I want this to work for everyone; that means when you clone it down it should
work for you. That said, I do use this as _my_ dotfiles, so there's a good
chance I may break something if I forget to make a check for a dependency.

If you're brand-new to the project and run into any blockers, please
[open an issue](https://github.com/alias-mac/dotfiles/issues) on this repository
and I'd love to get it fixed for you!
