local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("n", "<leader>cd", "<cmd>Telescope file_browser cwd_to_path=%:p:h<CR>", { desc = "Interactive cd from current file" })
map("n", "<leader>cD", "<cmd>cd %:p:h<CR><cmd>pwd<CR>", { desc = "Cd to current file directory" })
map("n", "<leader>cu", "<cmd>cd ..<CR><cmd>pwd<CR>", { desc = "Cd to parent directory" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<leader>x", "<cmd>bd<CR>", { desc = "Close buffer" })

map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

map("n", "<C-d>", "<C-d>zz", { desc = "Half-page down, centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half-page up, centered" })
map("n", "n", "nzzzv", { desc = "Next search result, centered" })
map("n", "N", "Nzzzv", { desc = "Prev search result, centered" })

map("n", "<leader>n", function()
  if vim.wo.relativenumber then
    vim.wo.relativenumber = false
    vim.wo.number = true
  else
    vim.wo.relativenumber = true
    vim.wo.number = true
  end
end, { desc = "Toggle relative/absolute line numbers" })

map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
