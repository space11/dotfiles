# dotfiles

GNU Stow-managed dotfiles. Each top-level directory is a stow package whose contents mirror `$HOME`; stow symlinks them into place.

## Packages

| Package | Contents |
|---------|----------|
| `zsh`   | `.zshrc`, `.zprofile`, `.zfunc/` (autoloaded functions, e.g. `tat`) |
| `git`   | `.gitconfig` |
| `nvim`  | `.config/nvim/` (lazy.nvim config) |

## Setup on a new machine

```
git clone https://github.com/space11/dotfiles.git ~/Code/personal/dotfiles
cd ~/Code/personal/dotfiles && stow -t ~ zsh git nvim
```

## Day-to-day

- Edit configs in place (the home files are symlinks into this repo), then commit.
- Add a new dotfile: put it in the matching package path (e.g. `zsh/.zshenv`), then run `stow -R -t ~ zsh`.
- Add a new package: create `<pkg>/` mirroring `$HOME`, then run `stow -t ~ <pkg>`.
- Remove a package's symlinks: `stow -D -t ~ <pkg>`.
