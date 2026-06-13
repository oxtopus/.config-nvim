# Neovim Config

Personal Neovim configuration managed with [lazy.nvim](https://github.com/folke/lazy.nvim).

## Docs

| File | Purpose |
|------|---------|
| [AGENTS.md](AGENTS.md) | Architecture, plugin specs, LSP setup, conventions for modifying this config |
| [CHEATSHEET.md](CHEATSHEET.md) | Keybindings quick reference (leader = `<Space>`) |

## Quick Start

```bash
# Clone and launch — lazy.nvim bootstraps itself on first run
nvim
```

Once plugins load:
- `<Space>ff` — find files
- `<Space>fg` — search project
- `<Space>e` — file tree
- `<Space>gg` — LazyGit

## Maintenance

```vim
:Lazy sync     " Update plugins
:Mason         " Manage LSP servers / formatters / linters
:checkhealth   " Diagnose issues
```

## System Dependencies

`git`, `node`, `python`, `ripgrep`, `fd`, `fzf`, `make`, `terraform`

> For the full plugin inventory, LSP/format/lint pipeline, and code conventions, see [AGENTS.md](AGENTS.md).
