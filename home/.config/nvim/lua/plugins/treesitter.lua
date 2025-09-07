---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  build = function()
    -- Safe build function with error handling
    local ok, install = pcall(require, "nvim-treesitter.install")
    if ok then
      install.update({ with_sync = true })()
    end
  end,
  event = { "BufReadPost", "BufNewFile" },
  opts = function()
    return {
      -- Only install essential parsers
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
      },
      
      -- Conservative sync install
      sync_install = false,
      auto_install = false,
      
      -- Core modules configuration
      highlight = {
        enable = true,
        disable = function(lang, buf)
          -- Disable for large files
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = false,
      },
      
      -- Essential modules only
      indent = {
        enable = true,
        disable = { "python", "yaml" },
      },
      
      -- Disable incremental selection to avoid conflicts
      incremental_selection = { enable = false },
      
      -- Disable text objects to avoid dependency issues
      textobjects = { enable = false },
    }
  end,
  
  config = function(_, opts)
    -- Safe configuration with error handling
    local ok, treesitter = pcall(require, "nvim-treesitter.configs")
    if ok then
      treesitter.setup(opts)
    else
      vim.notify("Tree-sitter setup failed, continuing without it", vim.log.levels.WARN)
    end
  end,
}