return {
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    opts = {},
  },

  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      mappings = { comment = "gc", comment_line = "gcc", textobject = "gc" },
    },
  },

  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    opts = {},
  },

  {
    "numToStr/Comment.nvim",
    enabled = false,
  },

  {
    "windwp/nvim-autopairs",
    enabled = false,
  },

  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>",  desc = "Toggle diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer diagnostics" },
      { "<leader>xs", "<cmd>Trouble symbols toggle<CR>",      desc = "Toggle symbols" },
      { "<leader>xl", "<cmd>Trouble lsp toggle<CR>",          desc = "LSP references/definitions" },
    },
    opts = {},
  },

  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true,
      highlight = { keyword = "wide" },
    },
  },
}

