# Alias does dotfiles

## dotfiles

Your [dotfiles](http://dotfiles.github.com) are how you personalize your system.
These are mine based on [holman's dot files](https://github.com/holman/dotfiles)
but more focused on `zsh`. If you match up along most of those lines, you may
dig my dotfiles.

I was a little tired of having long alias files and everything strewn about
(which is extremely common on other dotfiles projects, too). That led to this
project being much more topic-centric. I realized I could split a lot of things
up into the main areas I used (git, node, system libraries, and so on), so I
structured the project accordingly.

Everything is managed with [chezmoi](https://www.chezmoi.io) for templating and
machine-specific config, and [mise](https://mise.jdx.dev) for tool version
management.

## Install

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

## Topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell.

### Components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **Brewfile**: This is a list of packages and applications for
  [Homebrew](https://brew.sh) to install: things like git, coreutils, or
  applications like iTerm2, Raycast and VSCode. Might want to edit this file
  before running any initial setup.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **dot\_\***: Files managed by chezmoi, placed in your `$HOME` (e.g.,
  `dot_zshrc` becomes `~/.zshrc`).
- **dot\_\*.tmpl**: Templated files — chezmoi substitutes variables like
  name, email, and OS.
- **.chezmoiscripts/**: Scripts that run automatically during `chezmoi apply`
  (Homebrew, mise install, macOS preferences).
- **.chezmoiexternals/**: External dependencies managed by chezmoi (zsh
  plugins, mise binary).

## Bugs

I want this to work for everyone; that means when you clone it down it should
work for you. That said, I do use this as _my_ dotfiles, so there's a good
chance I may break something if I forget to make a check for a dependency.

If you're brand-new to the project and run into any blockers, please
[open an issue](https://github.com/alias-mac/dotfiles/issues) on this repository
and I'd love to get it fixed for you!
