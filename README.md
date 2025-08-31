<h1 align="center">⌨️ Miovim</h1>

<p align="center">
  <i>
    From the Spanish word <strong>'mío'</strong>, meaning <em>'mine'</em> —<br/>
    so it loosely translates to <strong>MyVim</strong>.
  </i>
</p>

<p align="center">
  A no-nonsense Neovim setup for people who just want to code.
</p>

> [!WARNING]
> Miovim is not compatible with **Neovim versions older than 0.12**. Make sure
> you're running nightly to avoid issues.

## 🚩 Introduction

**Miovim** doesn't rely on `lazy.nvim` or any external plugin manager.  Instead,
it uses [`vim.pack`](https://neovim.io/doc/user/pack.html#_plugin-manager) —
Neovim's upcoming **native plugin manager**, still under development. Expect
some rough edges.

This approach enables an extremely minimal configuration, but comes with a
trade-off: **native lazy loading isn't yet supported**.

To mitigate this, `vim.loader` is enabled for faster startup. I might take a
look at [`lz.n`](https://github.com/nvim-neorocks/lz.n) at some point.

## 📦 Dependencies

> [!IMPORTANT]
> **Miovim does not use
> [Mason.nvim](https://github.com/mason-org/mason.nvim).** Language servers
> and external tools must be installed manually or through your system's package
> manager. This configuration is primarily developed and used on **NixOS**, but
> it's adaptable to other environments.

Make sure you have the following dependencies installed:

- A **C compiler**
- [`fzf`](https://github.com/junegunn/fzf)
- [`ripgrep`](https://github.com/BurntSushi/ripgrep) *(optional on Linux/macOS,
  but recommended)*
- [`fd`](https://github.com/sharkdp/fd) *(optional but recommended)*

## ⚙️ Installation

### 🐧 Unix-like systems (Linux, macOS, WSL...)

```bash
git clone https://github.com/warbacon/nvim-config "$HOME/.config/nvim"
```

### 🪟 Windows

> [!IMPORTANT]
> Neovim is slower on Windows. Using
> [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) is recommended.

```bash
git clone https://github.com/warbacon/nvim-config "$HOME\AppData\Local\nvim"
```
