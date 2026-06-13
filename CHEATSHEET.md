# Neovim Cheatsheet

> **Leader:** `<Space>` — all `<leader>` keys are `<Space>` + the letter(s) shown.

---

## Files & Navigation

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files (fuzzy) |
| `<leader>fg` | Live grep (search project) |
| `<leader>fb` | Open buffers |
| `<leader>fr` | Recent files |
| `<leader>fd` | File browser |
| `<leader>e` | Toggle file tree (Neo-tree) |
| `<leader>w` | Save file |
| `<leader>x` | Close buffer |
| `<leader>q` | Quit window |
| `<C-d>` / `<C-u>` | Half-page down/up (centered) |

## Window Navigation

| Key | Action |
|-----|--------|
| `<C-h>` | Left window |
| `<C-j>` | Window below |
| `<C-k>` | Window above |
| `<C-l>` | Right window |

## Search & Symbols

| Key | Action |
|-----|--------|
| `<leader>fs` | Document symbols |
| `<leader>fS` | Workspace symbols |
| `<leader>fh` | Help tags |
| `<leader>f:` | Commands |
| `<leader>fk` | Keymaps |
| `n` / `N` | Next/prev search result (centered) |

## LSP (Language Server)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gi` | Go to implementation |
| `gD` | Go to declaration |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions (quick fix) |
| `<leader>fm` | Format buffer (LSP) |
| `<leader>F` | Format buffer/selection (Conform) |

### Completion (blink.cmp)

| Key | Action |
|-----|--------|
| `<Tab>` | Select next suggestion |
| `<S-Tab>` | Select previous suggestion |
| `<CR>` | Accept suggestion |

## Git (gitsigns + lazygit)

| Key | Action |
|-----|--------|
| `<leader>gg` | Open LazyGit |
| `]h` / `[h` | Next / previous hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage entire buffer |
| `<leader>hu` | Undo stage hunk |
| `<leader>hp` | Preview hunk inline |
| `<leader>hb` | Blame line (full commit) |
| `<leader>tb` | Toggle line blame |
| `<leader>td` | Toggle deleted lines |

## Diagnostics (Trouble)

| Key | Action |
|-----|--------|
| `<leader>xx` | Toggle diagnostics list |
| `<leader>xX` | Toggle buffer diagnostics |
| `<leader>xs` | Toggle symbols |
| `<leader>xl` | LSP references / definitions |

## Editing

| Key | Action |
|-----|--------|
| `gc` | Comment operator (motion) |
| `gcc` | Comment current line |
| `J` / `K` (visual) | Move selection down / up |
| `<leader>y` | Yank to system clipboard |
| `<leader>n` | Toggle relative/absolute line numbers |
| `<leader>cd` | Change working dir to current file |
| `<leader>cu` | Change working dir to parent |

## Other Useful Commands

| Command | Purpose |
|---------|---------|
| `:Mason` | Manage LSP servers / tools |
| `:LspInfo` | LSP status |
| `:ConformInfo` | Formatter status |
| `:Lazy` | Plugin manager |
| `:Lazy sync` | Update & sync plugins |
| `:checkhealth` | Plugin health check |
