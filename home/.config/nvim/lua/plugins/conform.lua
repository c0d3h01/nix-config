---@type LazySpec
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  opts = {
    format_on_save = function(bufnr)
      -- Get the astrolsp config safely
      local astrolsp_ok, astrolsp = pcall(require, "astrolsp")
      if astrolsp_ok and astrolsp.config and astrolsp.config.formatting then
        if not astrolsp.config.formatting.format_on_save.enabled then return end
      end

      -- Safe format configuration
      return {
        timeout_ms = 2000,
        lsp_format = "fallback",
        quiet = true, -- Don't show errors for missing formatters
      }
    end,

    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      yml = { "prettier" },
      markdown = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      html = { "prettier" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      zsh = { "shfmt" },
    },

    -- Formatter configurations
    formatters = {
      stylua = {
        prepend_args = { "--config-path", vim.fn.expand "~/.config/nvim/.stylua.toml" },
      },
      black = {
        prepend_args = { "--line-length", "88", "--fast" },
      },
      prettier = {
        prepend_args = { "--tab-width", "2", "--print-width", "100" },
      },
      shfmt = {
        prepend_args = { "-i", "2", "-ci", "-sr" },
      },
    },

    -- Notify on format errors but don't block
    notify_on_error = false,
    notify_no_formatters = false,
  },

  config = function(_, opts)
    local conform = require "conform"
    conform.setup(opts)

    -- Add a command to format current buffer manually
    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end
      conform.format { async = true, lsp_format = "fallback", range = range }
    end, { range = true })
  end,
}
