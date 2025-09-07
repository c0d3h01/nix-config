-- Stable user plugin configuration

---@type LazySpec
return {
  -- Discord presence (optional)
  {
    "andweeb/presence.nvim",
    event = "VeryLazy",
    opts = {
      auto_update = true,
      neovim_image_text = "The One True Text Editor",
      main_image = "neovim",
      log_level = nil,
      debounce_timeout = 10,
      enable_line_number = false,
      blacklist = {},
      buttons = true,
      file_assets = {},
    },
  },

  -- LSP signature help
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
      bind = true,
      handler_opts = {
        border = "rounded",
      },
      floating_window = false, -- Use virtual text instead
      hint_enable = true,
      hint_prefix = "🐼 ",
      hi_parameter = "LspSignatureActiveParameter",
      max_height = 12,
      max_width = 80,
      transparency = nil,
      shadow_guibg = "Black",
      shadow_blend = 36,
      timer_interval = 200,
      toggle_key = nil,
    },
    config = function(_, opts) require("lsp_signature").setup(opts) end,
  },

  -- Enhanced dashboard
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        enabled = true,
        preset = {
          header = table.concat({
            " ██████╗ ██████╗ ██████╗ ██████╗ ██╗  ██╗ ██████╗  ██╗",
            "██╔════╝██╔═████╗██╔══██╗╚════██╗██║  ██║██╔═████╗███║",
            "██║     ██║██╔██║██║  ██║ █████╔╝███████║██║██╔██║╚██║",
            "██║     ████╔╝██║██║  ██║ ╚═══██╗██╔══██║████╔╝██║ ██║",
            "╚██████╗╚██████╔╝██████╔╝██████╔╝██║  ██║╚██████╔╝ ██║",
            " ╚═════╝ ╚═════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝ ╚═════╝  ╚═╝",
          }, "\n"),
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
    },
  },

  -- Disable problematic plugins
  { "max397574/better-escape.nvim", enabled = false },

  -- Enhanced LuaSnip configuration
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    config = function(plugin, opts)
      -- Include default AstroNvim config
      require "astronvim.plugins.configs.luasnip"(plugin, opts)

      local luasnip = require "luasnip"

      -- Extend filetypes
      luasnip.config.setup {
        history = true,
        updateevents = "TextChanged,TextChangedI",
        delete_check_events = "TextChanged",
        ext_opts = {
          [require("luasnip.util.types").choiceNode] = {
            active = {
              virt_text = { { "choiceNode", "Comment" } },
            },
          },
        },
      }

      -- Load snippets
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").load()

      -- Filetype extensions
      luasnip.filetype_extend("javascript", { "javascriptreact" })
      luasnip.filetype_extend("typescript", { "typescriptreact" })
      luasnip.filetype_extend("python", { "django" })
    end,
  },

  -- Enhanced autopairs
  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      -- Include default AstroNvim config
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts)

      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"

      -- Add custom rules
      npairs.add_rules {
        -- LaTeX rules
        Rule("$", "$", { "tex", "latex" })
          :with_pair(cond.not_after_regex "%%")
          :with_move(cond.none())
          :with_cr(cond.none()),

        -- Python f-string rules
        Rule("f'", "'", "python"),
        Rule('f"', '"', "python"),

        -- Markdown code blocks
        Rule("```", "```", "markdown"):with_cr(cond.none()):with_move(cond.done()),
      }

      -- Integration with treesitter
      local ts_conds = require "nvim-autopairs.ts-conds"
      npairs.add_rules {
        Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node { "string", "comment" }),
        Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node { "function" }),
      }
    end,
  },

  -- Color highlighting
  {
    "brenoprata10/nvim-highlight-colors",
    event = "BufRead",
    opts = {
      render = "background",
      enable_named_colors = true,
      enable_tailwind = true,
    },
  },

  -- Session management enhancement
  {
    "stevearc/resession.nvim",
    opts = {
      autosave = {
        enabled = true,
        interval = 60,
        notify = false,
      },
      extensions = {
        quickfix = {},
      },
    },
  },
}
