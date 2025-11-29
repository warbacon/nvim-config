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
> system's package manager. This configuration is primarily developed and tested
> on **NixOS**, but it's easily adaptable to other environments.

Make sure you have the following dependencies installed:

- A **C compiler**
- [`ripgrep`](https://github.com/BurntSushi/ripgrep) — optional on Linux/macOS,
but recommended
- [`fd`](https://github.com/sharkdp/fd) — optional but recommended

## 🛠️ Installation

### 🐧 Unix-like systems (Linux, macOS, WSL...)

```bash
git clone https://github.com/warbacon/nvim-config "$HOME/.config/nvim"
```

### 🪟 Windows

> [!IMPORTANT]
> Neovim tends to run slower on Windows. Using
> [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) is recommended.

> [!WARNING]
> Additional Tree-sitter parsers are not installed on Windows, since building
> them requires MSVC — and honestly, it's just not worth the hassle (use any
> other OS if you want to code).

```bash
git clone https://github.com/warbacon/nvim-config "$HOME\AppData\Local\nvim"
```
