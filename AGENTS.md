# Neovim Configuration

## Directory Structure

```
~/.config/nvim/
├── init.lua                        # Entry point → options → keymaps → lazy
├── lua/
│   ├── config/
│   │   ├── options.lua             # vim.opt settings
│   │   ├── keymaps.lua             # Leader key, window nav, Telescope binds
│   │   └── lazy.lua                # lazy.nvim bootstrap + plugin import
│   └── plugins/
│       ├── ui.lua                  # tokyonight, lualine, which-key, bufferline
│       ├── lsp.lua                 # Mason + mason-lspconfig + nvim-lspconfig + blink.cmp
│       ├── treesitter.lua          # nvim-treesitter (18 parsers) + treesitter-textobjects
│       ├── telescope.lua           # Telescope + fzf-native + file-browser
│       ├── neo-tree.lua            # File tree sidebar
│       ├── formatting.lua          # conform.nvim (auto-format on save)
│       ├── linting.lua             # nvim-lint (auto-lint on save/write)
│       ├── git.lua                 # gitsigns + lazygit.nvim
│       └── editor.lua              # mini.pairs, mini.comment, mini.surround, trouble, todo-comments
```

## Plugin Manager: lazy.nvim

- Bootstrapped on first launch from GitHub (stable branch)
- Plugins imported via `{ import = "plugins" }` — each plugin file in `lua/plugins/` returns a spec table
- `defaults = { lazy = true }` — all plugins lazy-load unless `lazy = false`
- `checker = { enabled = true, notify = false }` — checks for updates silently
- `install.colorscheme = { "tokyonight" }` — ensures colorscheme loads first
- `ui = { border = "rounded" }`

## Architecture Patterns

### Option 1: Use `opts` (preferred for simple plugins)
```lua
{
  "author/plugin.nvim",
  event = "BufReadPre",
  opts = {
    setting = value,
  },
}
```
lazy.nvim calls `require("plugin").setup(opts)` automatically.

### Option 2: Use `main` + `opts` (when setup module differs)
```lua
{
  "nvim-treesitter/nvim-treesitter",
  main = "nvim-treesitter.configs",
  opts = { highlight = { enable = true } },
}
```

### Option 3: Use `config` function (when you need explicit setup)
```lua
{
  "author/plugin.nvim",
  config = function()
    require("plugin").setup({ ... })
  end,
}
```

### Keymap pattern
```lua
-- Global: in keymaps.lua using vim.keymap.set
map("n", "<leader>x", "<cmd>...<CR>", { desc = "Description" })

-- Buffer-local: in plugin config on_attach
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })

-- Telescope keys: use `keys` spec field with desc for which-key integration
keys = {
  { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
}
```

## LSP Configuration

### Servers installed via Mason
| Mason package | lspconfig name | Language |
|---------------|---------------|----------|
| pyright | pyright | Python |
| typescript-language-server | ts_ls | TypeScript/JavaScript |
| terraform-ls | terraformls | Terraform/HCL |
| dockerfile-language-server | dockerls | Docker |
| lua-language-server | lua_ls | Lua |
| json-lsp | jsonls | JSON |
| yaml-language-server | yamlls | YAML |
| bash-language-server | bashls | Bash |
| marksman | marksman | Markdown |

### How it works
1. `mason.nvim` manages installing/updating LSP server binaries
2. `mason-lspconfig.nvim` bridges Mason packages to lspconfig names
3. `nvim-lspconfig` configures each server with capabilities from blink.cmp
4. `on_attach` sets buffer-local keymaps for each LSP-attached buffer
5. `blink.cmp` provides autocompletion (sources: lsp, path, snippets, buffer)

### Adding a new LSP server
1. Add to `mason-lspconfig` `ensure_installed` list
2. Add a key to the `servers` table in the lspconfig config function
3. Run `:MasonInstall <package-name>`

## Formatting (conform.nvim)

- Auto-formats on save via `format_on_save` (uses `lsp_format = "fallback"`)
- Manual format: `<space>F`
- Disable auto-format with `vim.g.disable_autoformat = true` or `vim.b.disable_autoformat = true`

### Formatters installed via Mason
| Mason package | Tool | Filetypes |
|---------------|------|-----------|
| ruff | ruff format | python |
| prettierd | @fsouza/prettierd | javascript, typescript, jsx, tsx, json, yaml, markdown, html, css |
| stylua | stylua | lua |

`terraform_fmt` uses the system terraform binary (not Mason-managed).

### Adding a new formatter
1. Install formatter binary (Mason or system)
2. Add entry to `formatters_by_ft` in `formatting.lua`

## Linting (nvim-lint)

- Auto-lints on BufWritePost, BufReadPost, InsertLeave
- Only activates eslint_d when eslint config file is found (upward search)

### Linters installed via Mason
| Mason package | Tool | Filetypes |
|---------------|------|-----------|
| ruff | ruff | python |
| eslint_d | eslint_d | javascript, typescript, jsx, tsx |

### Adding a new linter
1. Install linter binary (Mason or system)
2. Add entry to `linters_by_ft` in `linting.lua`

## Treesitter

### Parsers (18)

python, javascript, typescript, tsx, lua, hcl, terraform, dockerfile, json, yaml, bash, markdown, markdown_inline, html, css, vimdoc, regex, query

### Parser installation

A `FileType` autocmd calls `pcall(vim.treesitter.language.add, lang)` for the current filetype, attempting to auto-install missing parsers on-the-fly.

### Textobjects (treesitter-textobjects)

| Key | Action |
|-----|--------|
| `af` / `if` | Around / inner function |
| `ac` / `ic` | Around / inner class |

## Keymaps Reference

### Leader
- `<leader>` = `<space>`
- `<localleader>` = `<space>`

### File Operations
| Key | Command | Plugin |
|-----|---------|--------|
| `<leader>ff` | `Telescope find_files` | telescope |
| `<leader>fg` | `Telescope live_grep` | telescope |
| `<leader>fb` | `Telescope buffers` | telescope |
| `<leader>fh` | `Telescope help_tags` | telescope |
| `<leader>fr` | `Telescope oldfiles` | telescope |
| `<leader>fs` | `Telescope lsp_document_symbols` | telescope |
| `<leader>fS` | `Telescope lsp_workspace_symbols` | telescope |
| `<leader>f:` | `Telescope commands` | telescope |
| `<leader>fk` | `Telescope keymaps` | telescope |
| `<leader>fd` | `Telescope file_browser` | telescope |
| `<leader>cd` | `Telescope file_browser` from current file path | telescope |
| `<leader>cD` | Cd to current file directory | built-in |
| `<leader>cu` | Cd to parent directory | built-in |
| `<leader>e` | Neotree toggle | neo-tree |
| `<leader>w` | Write (save) | built-in |
| `<leader>q` | Quit | built-in |
| `<leader>x` | Close buffer | built-in |

### Window Navigation
| Key | Action |
|-----|--------|
| `<C-h>` | Move to left window |
| `<C-j>` | Move to window below |
| `<C-k>` | Move to window above |
| `<C-l>` | Move to right window |
| `<S-h>` | Previous buffer |
| `<S-l>` | Next buffer |
| `[b` | Previous buffer |
| `]b` | Next buffer |
| `<leader>bp` | Pin buffer |
| `<leader>bP` | Close unpinned buffers |

### LSP
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Go to references |
| `gi` | Go to implementation |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>fm` | Format buffer (LSP) |
| `<leader>F` | Format buffer/selection (conform) |

### Git
| Key | Action |
|-----|--------|
| `<leader>gg` | Open LazyGit |
| `]h` | Next hunk |
| `[h` | Previous hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage buffer |
| `<leader>hu` | Undo stage hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line (full) |
| `<leader>tb` | Toggle line blame |
| `<leader>td` | Toggle deleted |

### Diagnostics
| Key | Action |
|-----|--------|
| `<leader>xx` | Toggle diagnostics (trouble) |
| `<leader>xX` | Toggle buffer diagnostics (trouble) |
| `<leader>xs` | Toggle symbols (trouble) |
| `<leader>xl` | LSP references/definitions (trouble) |

### Editor
| Key | Action |
|-----|--------|
| `gc` | Comment (operator) |
| `gcc` | Comment line |
| `<leader>y` | Yank to system clipboard |
| `J` (visual) | Move selection down |
| `K` (visual) | Move selection up |
| `<C-d>` | Half-page down, centered |
| `<C-u>` | Half-page up, centered |
| `n` / `N` | Next / prev search result, centered |
| `<leader>n` | Toggle relative/absolute line numbers |

## Vim Options (options.lua)

| Setting | Value | Rationale |
|---------|-------|-----------|
| number | true | Line numbers |
| relativenumber | true | Relative line numbers (easier jumps) |
| mouse | a | Mouse support in all modes |
| clipboard | unnamedplus | System clipboard sync |
| undofile | true | Persistent undo history |
| expandtab | true | Spaces instead of tabs |
| shiftwidth | 2 | Indent width |
| tabstop | 2 | Tab display width |
| softtabstop | 2 | Soft tab stop |
| smartindent | true | Smart auto-indent |
| wrap | false | No line wrapping |
| scrolloff | 8 | Keep cursor 8 lines from edge |
| splitbelow | true | New splits open below |
| splitright | true | New vsplits open right |
| ignorecase | true | Case-insensitive search |
| smartcase | true | Override ignorecase when uppercase used |
| hlsearch | false | Don't highlight search matches |
| incsearch | true | Incremental search |
| termguicolors | true | 24-bit color |
| signcolumn | yes | Always show sign column (avoids layout shift) |
| cursorline | true | Highlight current line |
| colorcolumn | 120 | Ruler at column 120 |
| updatetime | 250 | Faster CursorHold (for git blame, diagnostics) |
| timeoutlen | 400 | Faster which-key popup |

## Maintenance

### Update plugins
```vim
:Lazy sync
:Lazy update
```

### Install new LSP server
```vim
:Mason
```
Then navigate and press `i` to install.

Or: `:MasonInstall <package-name>`

### Check LSP status
```vim
:LspInfo
```

### Check formatter status
```vim
:ConformInfo
```

### Plugin health check
```vim
:checkhealth
```

## Dependencies

System packages required (all present):
- Neovim >= 0.10 (0.12.2 installed)
- Git
- Node.js (for LSP servers: pyright, ts_ls, jsonls, yamlls, bashls, eslint_d, prettierd)
- Python 3 (for ruff)
- Terraform (for terraform fmt, terraform-ls)
- ripgrep (Telescope live_grep)
- fd (Telescope find_files optional, faster)
- fzf (Telescope fzf-native)
- make (for telescope-fzf-native build)
- lazygit (for lazygit.nvim — not installed on this system)

## Colorscheme

tokyonight (night variant), set as lazy.nvim install colorscheme to ensure it loads first.
To change: edit `lua/plugins/ui.lua` and update `vim.cmd.colorscheme(...)`.
