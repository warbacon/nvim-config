<h1 align="center">⌨️ Miovim</h1>

<p align="center">
  <i>
    From the Spanish word <strong>'mío'</strong>, meaning <em>'mine'</em> —<br/>
    so it loosely translates to <strong>MyVim</strong>.
  </i>
</p>

<p align="center">
  A fast, no-nonsense Neovim configuration for those who want performance and elegance — nothing else.
</p>

> [!WARNING]
> Miovim is not compatible with **Neovim versions older than 0.11**. Make sure
> you're running a recent build to avoid issues.

## 🚩 Goals

- ⚡ **Maximum performance.** No unnecessary plugins, no bloat. Only what’s
  needed to stay fast, focused, and efficient.
- 🚀 **Startup under 100ms.** Opens faster than you can blink. Most of the time
  it feels instant — because it practically is.
- 🎯 **Minimalist, beautiful interface.** Clean UI with helpful visuals, but
  never in your way. Designed to let you focus entirely on code, not on your
  editor.
- 🧠 **Neovim-first philosophy.** Miovim builds on Neovim's own capabilities
  and embraces its native features as the default path.  Instead of imitating
  traditional IDE behavior, Miovim enhances Neovim *as Neovim*, while staying
  consistent and powerful.

## 📦 Dependencies

> [!INFO]
> **Miovim does not use
> [Mason.nvim](https://github.com/mason-org/mason.nvim).**  Language servers
> and external tools must be installed manually or through your system's package
> manager.  This configuration is primarily developed and used on **NixOS**, but
> it's adaptable to other environments.

Make sure you have the following dependencies installed:

- A **C compiler** – required by nvim-treesitter for compiling parsers.
- `tree-sitter` CLI – for installing tree-sitter parsers.
- [`fzf`](https://github.com/junegunn/fzf) – for
  [fzf-lua](https://github.com/ibhagwan/fzf-lua).
- [`ripgrep`](https://github.com/BurntSushi/ripgrep) – for faster file searching
  in fzf-lua.

## ⚙️ Installation

### 🐧 Linux

```bash
git clone https://github.com/warbacon/nvim-config "$HOME/.config/nvim"
```

### 🪟 Windows

```bash
git clone https://github.com/warbacon/nvim-config "$HOME\AppData\Local\nvim"
```

---

> [!NOTE]
> After cloning, launch `nvim` and let it install plugins automatically.
