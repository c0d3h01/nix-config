---@type LazySpec
return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate" },
    build = function()
      -- Safe build with error handling
      pcall(function() vim.cmd("MasonUpdate") end)
    end,
    opts = {
      ui = {
        border = "rounded",
        width = 0.8,
        height = 0.8,
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
      install_root_dir = vim.fn.stdpath("data") .. "/mason",
      pip = { upgrade_pip = false },
      log_level = vim.log.levels.INFO,
      max_concurrent_installers = 2, -- Prevent overwhelm
    },
  },
  
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    cmd = { "MasonToolsInstall", "MasonToolsUpdate" },
    opts = {
      -- Minimal, essential tools only
      ensure_installed = {
        -- Core LSP servers
        "lua-language-server",
        "pyright",
        "json-lsp",
        
        -- Essential formatters
        "stylua",
        "prettier",
        "black",
      },
      
      auto_update = false,
      run_on_start = false,
      start_delay = 0,
      debounce_hours = 24,
    },
  },
}