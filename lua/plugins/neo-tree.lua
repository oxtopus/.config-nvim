return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      {
        "<leader>e",
        function()
          -- Skip reveal for non-file buffers (checkhealth, help, terminal, etc.)
          if vim.bo.buftype ~= "" then
            vim.cmd("Neotree toggle")
          else
            vim.cmd("Neotree toggle reveal")
          end
        end,
        desc = "Toggle file tree",
      },
    },
    opts = {
      close_if_last_window = true,
      window = { position = "left", width = 35 },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
        follow_current_file = { enabled = true },
      },
      default_component_configs = {
        modified = { symbol = "[+]" },
        git_status = { symbols = { added = "", deleted = "", modified = "", renamed = "", untracked = "", ignored = "", unstaged = "", staged = "" } },
      },
      event_handlers = {
        {
          event = "file_opened",
          handler = function()
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },
    },
  },
}
