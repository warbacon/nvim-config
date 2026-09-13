<h1 align="center">⌨️ Miovim</h1>

<p align="center">
  <i>
    From the Spanish word <b>"mío"</b>, meaning "mine",<br/>
    because this is <b>my</b> way of using Vim.
  </i>
</p>

<p align="center">
  A no-nonsense Neovim setup for people who just want to sit down and code.
</p>

> [!WARNING]
> **Miovim** isn't compatible with **Neovim versions earlier than 0.12**. Make
> sure you are using at least the latest stable version.

## 🤨 Why Miovim?

**Miovim** is built to be simple, fast, and fully understandable.

## 📦 Dependencies

Before using Miovim, make sure you have:

- A **C compiler**
  - Any standard compiler on Linux/macOS
  - **MSVC** on Windows
- [`tree-sitter`](https://github.com/tree-sitter/tree-sitter)
- [`ripgrep`](https://github.com/BurntSushi/ripgrep) and
  [`fd`](https://github.com/sharkdp/fd) (optional)

## 🛠️ Installation

### 🐧 Unix-like systems (Linux, macOS, WSL...)

```bash
git clone https://github.com/warbacon/nvim-config "$HOME/.config/nvim"
```

### 🪟 Windows

> [!IMPORTANT]
> Neovim runs slower on Windows. Using
> [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) is highly
> recommended.

#### PowerShell

```powershell
git clone https://github.com/warbacon/nvim-config "$env:LOCALAPPDATA\nvim"
```

#### CMD

```cmd
git clone https://github.com/warbacon/nvim-config %LOCALAPPDATA%\nvim
```
