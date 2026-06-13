return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "python",
        "javascript",
        "typescript",
        "tsx",
        "lua",
        "hcl",
        "terraform",
        "dockerfile",
        "json",
        "yaml",
        "bash",
        "markdown",
        "markdown_inline",
        "html",
        "css",
        "vimdoc",
        "regex",
        "query",
      })

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match) or args.match
          if pcall(vim.treesitter.language.add, lang) then
            pcall(vim.treesitter.start, args.buf, lang)
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
      })

      local select_to = require("nvim-treesitter-textobjects.select").select_textobject
      vim.keymap.set({ "x", "o" }, "af", function() select_to("@function.outer", "textobjects") end, { desc = "around function" })
      vim.keymap.set({ "x", "o" }, "if", function() select_to("@function.inner", "textobjects") end, { desc = "inner function" })
      vim.keymap.set({ "x", "o" }, "ac", function() select_to("@class.outer", "textobjects") end, { desc = "around class" })
      vim.keymap.set({ "x", "o" }, "ic", function() select_to("@class.inner", "textobjects") end, { desc = "inner class" })
    end,
  },
}
