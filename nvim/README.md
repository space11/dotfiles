Base on Launch.nvim configuration.

```sh
git clone https://github.com/LunarVim/Launch.nvim.git ~/.config/nvim
```

# 3rd Party software used by this cofig:

- On mac `pbcopy` should be builtin
- On Ubuntu
  ```sh
  sudo apt install xsel # for X11
  sudo apt install wl-clipboard # for wayland
  ```

Next we need to install python support (node is optional)

- Stylua

```sh
cargo install stylua --root ./rust_modules --version 0.9.2
```

And add `rust_modules` to the PATH env veriable.

- Neovim python support

  ```sh
  pip install pynvim
  ```

- Neovim node support

  ```sh
  npm i -g neovim
  ```

We will also need `ripgrep` for Telescope to work:

- Ripgrep

  ```sh
  sudo apt install ripgrep
  ```

---

## Fonts

I recommend using the following repo to get a "Nerd Font" (Font that supports icons)

[getnf](https://github.com/ronniedroid/getnf)
