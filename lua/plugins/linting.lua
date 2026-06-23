return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      linters_by_ft = {
        python = { "ruff" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        go = { "golangcilint" },
      },
      linters = {
        eslint_d = {
          condition = function(ctx)
            return vim.fs.find({ ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json", "eslint.config.js" }, {
              path = ctx.filename,
              upward = true,
            })[1]
          end,
        },
      },
    },
    config = function(_, opts)
      require("lint").linters_by_ft = opts.linters_by_ft
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("LintOnSave", { clear = true }),
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
}
