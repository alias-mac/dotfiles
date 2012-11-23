
# Alias does dotfiles

## dotfiles

Your [dotfiles](http://dotfiles.github.com) are how you personalize your system. These are mine based on [holman's dot files](https://github.com/holman/dotfiles) but more focused on `bash`. If you match up along most of those lines, you may dig my dotfiles.

I was a little tired of having long alias files and everything strewn about (which is extremely common on other dotfiles projects, too). That led to this project being much more topic-centric. I realized I could split a lot of things up into the main areas I used (PHP, git, system libraries, and so on), so I structured the project accordingly.

## Install

Run this:

```sh
git clone https://github.com/alias-mac/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
rake install
```

This will symlink the appropriate files in `.dotfiles` to your home directory. Everything is configured and tweaked within `~/.dotfiles`, though.

The main file you'll want to change right off the bat is `bash/bashrc.symlink`, which sets up a few paths that'll be different on your particular machine.

You'll also want to change `git/gitconfig.symlink`, which will set you up ascommitting as Zach Holman. You probably don't want that.

## Topical

Everything's built around topic areas. If you're adding a new area to your forked dotfiles — say, "Java" — you can simply add a `java` directory and put files in there. Anything with an extension of `.bash` will get automatically included into your shell. Anything with an extension of `.symlink` will get symlinked without extension into `$HOME` when you run `rake install`.

### Components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made available everywhere.
- **topic/\*.bash**: Any files ending in `.bash` get loaded into your environment.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into your `$HOME`. This is so you can keep all of those versioned in your dotfiles but still keep those autoloaded files in your home directory. These get symlinked in when you run `rake install`.
- **topic/\*.completion.bash**: Any files ending in `completion.bash` get loaded last so that they get loaded after we set up all `*.bash` files (dependencies).

## Add-ons

There are a few things I use to make my life awesome. They're not a required dependency, but if you install them they'll make your life a bit more like a bubble bath.

- If you want some more colors for things like `ls`, install grc: `brew install grc`.
- If you install the excellent [php-version](https://github.com/wilmoore/php-version) to manage multiple php versions.

## Bugs

I want this to work for everyone; that means when you clone it down it should work for you. That said, I do use this as *my* dotfiles, so there's a good chance I may break something if I forget to make a check for a dependency.

If you're brand-new to the project and run into any blockers, please
[open an issue](https://github.com/alias-mac/dotfiles/issues) on this repository and I'd love to get it fixed for you!

## Thanks

I forked [Zach Holman](http://github.com/holman)'s excellent
[dotfiles](http://github.com/holman/dotfiles) for a some years before the weight of my changes and tweaks inspired me to finally roll my own. But Holman's dotfiles were an easy way to get into bash customization. A decent amount of the code in these dotfiles stem or are inspired from Holman's original project.
