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
> **Miovim** is not compatible with **Neovim versions older than 0.11**. Make
> sure you're running at least the latest stable release.

## 🚩 Introduction

**Miovim** relies on `lazy.nvim` for plugin installation, but it doesn't use its
built-in lazy-loading mechanisms. Instead, it leverages the `later()` and
`now()` functions from the `mini.deps` module of the `mini.nvim` library.

This approach provides greater flexibility, simplifies the configuration, and
makes it easier to transition to `vim.pack` — the upcoming built-in plugin
manager currently in development for Neovim nightly.

## 📦 Dependencies

> [!IMPORTANT]
> **Miovim does not use [Mason.nvim](https://github.com/mason-org/mason.nvim).**
> Language servers and external tools must be installed manually or through your
> system's package manager. This configuration is primarily developed and used
> on **NixOS**, but it's adaptable to other environments.

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

> [!WARNING]
> Additional Tree-sitter parsers aren't installed because building them
> requires MSVC — and honestly, I'd rather not deal with that.

```bash
git clone https://github.com/warbacon/nvim-config "$HOME\AppData\Local\nvim"
```
