return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>",       desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>",        desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>",          desc = "Find buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>",        desc = "Help tags" },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>",         desc = "Recent files" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>",  desc = "Document symbols" },
      { "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<CR>", desc = "Workspace symbols" },
      { "<leader>f:", "<cmd>Telescope commands<CR>",         desc = "Commands" },
      { "<leader>fk", "<cmd>Telescope keymaps<CR>",          desc = "Keymaps" },
    },
    opts = {
      defaults = {
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.55 },
        },
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
          },
        },
      },
      pickers = {
        find_files = { hidden = true },
        live_grep = { additional_args = { "--hidden" } },
        buffers = { sort_mru = true },
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      pcall(require("telescope").load_extension, "fzf")
    end,
  },
}
