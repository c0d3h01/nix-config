---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  
  -- Core language packs
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.python" },
  
  {
    import = "astrocommunity.colorscheme.catppuccin",
    enabled = true,
  },
  {
    import = "astrocommunity.completion.copilot-lua",
    enabled = true,
  },
  
  -- Copilot configuration with safe defaults
  {
    "zbirenbaum/copilot.lua",
    enabled = true,
    opts = {
      panel = { enabled = false },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<Tab>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      filetypes = {
        yaml = false,
        markdown = true,
        help = false,
        gitcommit = true,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
    },
  },
}