-- Stable Mason configuration

---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      -- Essential tools for stable operation
      ensure_installed = {
        -- Language servers
        "lua-language-server",
        "pyright",
        "json-lsp",
        "yaml-language-server",
        "bash-language-server",
        "marksman", -- Markdown LSP

        -- Formatters
        "stylua", -- Lua formatter
        "prettier", -- JS/TS/JSON/YAML/Markdown formatter
        "black", -- Python formatter
        "shfmt", -- Shell formatter

        -- Diagnostics/Linters (optional, install only if available)
        -- "shellcheck", -- Uncomment if you want shell linting

        -- Debug adapters
        "debugpy", -- Python debugger

        -- Other tools
        "tree-sitter-cli",
      },
      auto_update = false, -- Disable auto-update for stability
      run_on_start = true,
      start_delay = 3000, -- Wait 3 seconds before installing
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
      install_root_dir = vim.fn.stdpath "data" .. "/mason",
      pip = {
        upgrade_pip = false, -- Don't upgrade pip automatically for stability
      },
      log_level = vim.log.levels.INFO,
    },
  },
}
