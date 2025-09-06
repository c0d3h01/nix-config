---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  event = "VeryLazy",
  dependencies = { "jay-babu/mason-null-ls.nvim" },
  opts = function(_, opts)
    local nls = require "null-ls"
    opts = opts or {}
    opts.sources = {
      nls.builtins.diagnostics.shellcheck,
      nls.builtins.diagnostics.hadolint,
      nls.builtins.diagnostics.actionlint,
      -- nls.builtins.diagnostics.ruff,
    }
    return opts
  end,
  config = function(_, opts)
    require("null-ls").setup(opts)
    require("mason-null-ls").setup {
      ensure_installed = { "shellcheck", "hadolint", "actionlint" },
      automatic_installation = false,
    }
  end,
}