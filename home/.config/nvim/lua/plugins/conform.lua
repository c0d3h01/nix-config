---@type LazySpec
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre", "BufNewFile" },
  opts = {
    format_on_save = function(bufnr)
      -- Respect your astrolsp.formatting.format_on_save.enabled
      if not require("astrolsp").config.formatting.format_on_save.enabled then
        return
      end
      return { timeout_ms = 1500, lsp_format = "fallback" }
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      nix = { "alejandra" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      zsh = { "shfmt" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      html = { "prettier" },
      -- python = { "ruff_format", "black" },  -- example layering
    },
    -- Optional: customize formatters
    formatters = {
      shfmt = { prepend_args = { "-i", "2", "-ci" } },
      alejandra = { command = "alejandra" },
    },
  },
}