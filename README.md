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
> **Miovim** is not compatible with **Neovim versions older than 0.11**.
> Make sure you're running at least the latest stable release.
>
> Miovim is continuously updated with the newest features from nightly builds!

## 🚩 Introduction

**Miovim** is built around one guiding principle: **keep it simple**. If a
configuration requires too much thinking to understand, **it gets discarded**.

This makes Miovim **easy to maintain**, **friendly for newcomers**, and
**pleasant to tweak**. Simplicity always comes before cleverness.

Lazy loading is used **only** when it's simple to implement or when a plugin is
particularly heavy.

Miovim is powered by [`lazy.nvim`](https://github.com/folke/lazy.nvim).

## 📦 Dependencies

> [!IMPORTANT]
> **Miovim does not use [Mason.nvim](https://github.com/mason-org/mason.nvim).**
> Language servers and external tools must be installed manually or through your
> system's package manager.

Make sure you have the following dependencies installed:

- A **C compiler**:
  - Any compiler should work on Linux/macOS
  - **MSVC** is required on Windows
- [`tree-sitter`](https://github.com/tree-sitter/tree-sitter)
- [`ripgrep`](https://github.com/BurntSushi/ripgrep)
- [`fd`](https://github.com/sharkdp/fd)

## 🛠️ Installation

### 🐧 Unix-like systems (Linux, macOS, WSL...)

```bash
git clone https://github.com/warbacon/nvim-config "$HOME/.config/nvim"
```

### 🪟 Windows

> [!IMPORTANT]
> Neovim tends to run slower on Windows. Using
> [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) is recommended.

```bash
git clone https://github.com/warbacon/nvim-config "$HOME\AppData\Local\nvim"
```
