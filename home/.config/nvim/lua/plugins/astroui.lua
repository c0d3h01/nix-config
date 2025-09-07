---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    colorscheme = "catppuccin-mocha",

    -- Custom highlight groups
    highlights = {
      init = {
        -- Modern window separators
        WinSeparator = { fg = "#313244", bg = "NONE" },
        VertSplit = { fg = "#313244", bg = "NONE" },

        -- Enhanced cursor line
        CursorLine = { bg = "#1e1e2e" },
        CursorLineNr = { fg = "#cba6f7", bg = "#1e1e2e", bold = true },
        LineNr = { fg = "#6c7086" },

        -- Modern selection colors
        Visual = { bg = "#45475a", fg = "NONE" },
        VisualNOS = { bg = "#45475a", fg = "NONE" },

        -- Enhanced search highlighting
        Search = { bg = "#f9e2af", fg = "#1e1e2e", bold = true },
        IncSearch = { bg = "#fab387", fg = "#1e1e2e", bold = true },
        CurSearch = { bg = "#f38ba8", fg = "#1e1e2e", bold = true },

        -- Modern status line colors
        StatusLine = { bg = "#181825", fg = "#cdd6f4" },
        StatusLineNC = { bg = "#11111b", fg = "#6c7086" },

        -- Enhanced popup menus
        Pmenu = { bg = "#1e1e2e", fg = "#cdd6f4" },
        PmenuSel = { bg = "#45475a", fg = "#cdd6f4", bold = true },
        PmenuSbar = { bg = "#313244" },
        PmenuThumb = { bg = "#585b70" },

        -- Modern floating windows
        FloatBorder = { fg = "#89b4fa", bg = "#1e1e2e" },
        NormalFloat = { bg = "#1e1e2e", fg = "#cdd6f4" },
        FloatTitle = { fg = "#cba6f7", bg = "#1e1e2e", bold = true },

        -- Enhanced diagnostics with modern colors
        DiagnosticError = { fg = "#f38ba8", bold = true },
        DiagnosticWarn = { fg = "#fab387", bold = true },
        DiagnosticInfo = { fg = "#89dceb", bold = true },
        DiagnosticHint = { fg = "#94e2d5", bold = true },

        -- Modern virtual text
        DiagnosticVirtualTextError = { fg = "#f38ba8", bg = "#2d1b21", italic = true },
        DiagnosticVirtualTextWarn = { fg = "#fab387", bg = "#2d2416", italic = true },
        DiagnosticVirtualTextInfo = { fg = "#89dceb", bg = "#1b2832", italic = true },
        DiagnosticVirtualTextHint = { fg = "#94e2d5", bg = "#1b2d28", italic = true },

        -- Enhanced LSP highlights
        LspReferenceText = { bg = "#45475a" },
        LspReferenceRead = { bg = "#45475a" },
        LspReferenceWrite = { bg = "#585b70" },

        -- Modern fold styling
        Folded = { bg = "#1e1e2e", fg = "#6c7086", italic = true },
        FoldColumn = { bg = "NONE", fg = "#45475a" },

        -- Enhanced diff colors
        DiffAdd = { bg = "#1e3a20", fg = "#a6e3a1" },
        DiffChange = { bg = "#2d2a1e", fg = "#f9e2af" },
        DiffDelete = { bg = "#3a1e1e", fg = "#f38ba8" },
        DiffText = { bg = "#3a2d1e", fg = "#fab387", bold = true },

        -- Modern Git signs
        GitSignsAdd = { fg = "#a6e3a1" },
        GitSignsChange = { fg = "#f9e2af" },
        GitSignsDelete = { fg = "#f38ba8" },

        -- Enhanced completion menu
        CmpItemAbbrMatch = { fg = "#89b4fa", bold = true },
        CmpItemAbbrMatchFuzzy = { fg = "#89b4fa", bold = true },
        CmpItemKindDefault = { fg = "#cdd6f4" },
        CmpItemMenu = { fg = "#6c7086", italic = true },

        -- Modern telescope styling
        TelescopeNormal = { bg = "#1e1e2e", fg = "#cdd6f4" },
        TelescopeBorder = { fg = "#89b4fa", bg = "#1e1e2e" },
        TelescopeTitle = { fg = "#cba6f7", bold = true },
        TelescopeSelection = { bg = "#45475a", fg = "#cdd6f4", bold = true },
        TelescopeMatching = { fg = "#f9e2af", bold = true },

        -- Enhanced tab line
        TabLine = { bg = "#11111b", fg = "#6c7086" },
        TabLineSel = { bg = "#1e1e2e", fg = "#cdd6f4", bold = true },
        TabLineFill = { bg = "#11111b" },

        -- Modern which-key styling
        WhichKey = { fg = "#89b4fa", bold = true },
        WhichKeyDesc = { fg = "#cdd6f4" },
        WhichKeyGroup = { fg = "#cba6f7", italic = true },
        WhichKeySeperator = { fg = "#6c7086" },

        -- Enhanced terminal colors
        TermCursor = { bg = "#f5e0dc", fg = "#1e1e2e" },
        TermCursorNC = { bg = "#6c7086", fg = "#1e1e2e" },
      },

      -- Catppuccin-specific enhancements
      catppuccin = function(colors)
        return {
          -- Modern gutter
          SignColumn = { bg = "NONE" },
          LineNr = { fg = colors.overlay0 },
          CursorLineNr = { fg = colors.lavender, style = { "bold" } },

          -- Enhanced syntax highlighting
          ["@keyword"] = { fg = colors.mauve, style = { "italic" } },
          ["@function"] = { fg = colors.blue, style = { "bold" } },
          ["@function.call"] = { fg = colors.blue },
          ["@method"] = { fg = colors.sapphire, style = { "italic" } },
          ["@parameter"] = { fg = colors.maroon, style = { "italic" } },
          ["@string"] = { fg = colors.green },
          ["@comment"] = { fg = colors.surface2, style = { "italic" } },
          ["@type"] = { fg = colors.yellow, style = { "bold" } },
          ["@constant"] = { fg = colors.peach, style = { "bold" } },
          ["@variable"] = { fg = colors.text },
          ["@variable.builtin"] = { fg = colors.red, style = { "italic" } },

          -- Modern HTML/JSX styling
          ["@tag"] = { fg = colors.red },
          ["@tag.attribute"] = { fg = colors.yellow, style = { "italic" } },
          ["@tag.delimiter"] = { fg = colors.overlay2 },

          -- Enhanced markdown
          ["@markup.heading"] = { fg = colors.blue, style = { "bold" } },
          ["@markup.heading.1"] = { fg = colors.red, style = { "bold" } },
          ["@markup.heading.2"] = { fg = colors.peach, style = { "bold" } },
          ["@markup.heading.3"] = { fg = colors.yellow, style = { "bold" } },
          ["@markup.link.label"] = { fg = colors.sapphire, style = { "underline" } },
          ["@markup.link.url"] = { fg = colors.lavender, style = { "italic", "underline" } },
          ["@markup.raw"] = { fg = colors.green, bg = colors.surface0 },

          -- Modern neo-tree
          NeoTreeNormal = { bg = colors.mantle },
          NeoTreeNormalNC = { bg = colors.mantle },
          NeoTreeDirectoryName = { fg = colors.blue },
          NeoTreeDirectoryIcon = { fg = colors.blue },
          NeoTreeRootName = { fg = colors.lavender, style = { "bold" } },
          NeoTreeFileName = { fg = colors.text },
          NeoTreeFileIcon = { fg = colors.text },
          NeoTreeGitModified = { fg = colors.yellow },
          NeoTreeGitAdded = { fg = colors.green },
          NeoTreeGitDeleted = { fg = colors.red },
          NeoTreeGitIgnored = { fg = colors.overlay0 },

          -- Enhanced heirline components
          HeirlineNormal = { bg = colors.base, fg = colors.text },
          HeirlineInsert = { bg = colors.green, fg = colors.base },
          HeirlineVisual = { bg = colors.mauve, fg = colors.base },
          HeirlineReplace = { bg = colors.red, fg = colors.base },
          HeirlineCommand = { bg = colors.yellow, fg = colors.base },
          HeirlineTerminal = { bg = colors.teal, fg = colors.base },
        }
      end,
    },

    -- Modern icon set with enhanced aesthetics
    icons = {
      -- Animated LSP loading icons
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",

      -- Modern file type icons
      ActiveLSP = "",
      ActiveTS = "",
      ArrowLeft = "",
      ArrowRight = "",
      Bookmarks = "",
      BufferClose = "󰅖",
      DapBreakpoint = "",
      DapBreakpointCondition = "",
      DapBreakpointRejected = "",
      DapLogPoint = ".>",
      DapStopped = "󰁕",
      Debugger = "",
      DefaultFile = "󰈙",
      Diagnostic = "󰒡",
      DiagnosticError = "",
      DiagnosticHint = "󰌶",
      DiagnosticInfo = "",
      DiagnosticWarn = "",
      Ellipsis = "…",
      Environment = "",
      FileNew = "",
      FileModified = "",
      FileReadOnly = "",
      FoldClosed = "",
      FoldOpened = "",
      FoldSeparator = " ",
      FolderClosed = "",
      FolderEmpty = "",
      FolderOpen = "",
      Git = "󰊢",
      GitAdd = "",
      GitBranch = "",
      GitChange = "",
      GitConflict = "",
      GitDelete = "",
      GitIgnored = "◌",
      GitRenamed = "➜",
      GitSign = "▎",
      GitStaged = "✓",
      GitUnstaged = "✗",
      GitUntracked = "★",
      LSPDocumentSymbol = "",
      LSPPackageLoaded = "●",
      LSPPackageLoading = "○",
      MacroRecording = "",
      Package = "󰏖",
      Paste = "󰅌",
      Refresh = "",
      Regex = "",
      Save = "💾",
      Search = "",
      Selected = "❯",
      Session = "󱂬",
      Sort = "󰒺",
      Spellcheck = "󰓆",
      Tab = "󰓩",
      TabClose = "󰅙",
      Terminal = "",
      Text = "",
      Tree = "",
      Triangle = "󰐊",
      TriangleShortArrowDown = "",
      TriangleShortArrowLeft = "",
      TriangleShortArrowRight = "",
      TriangleShortArrowUp = "",

      -- Enhanced kind icons for completion
      Array = "󰅪",
      Boolean = "⊨",
      Class = "󰠱",
      Color = "󰏘",
      Constant = "󰏿",
      Constructor = "",
      Copilot = "",
      Enum = "",
      EnumMember = "",
      Event = "",
      Field = "󰜢",
      File = "󰈚",
      Folder = "󰉋",
      Function = "󰊕",
      Interface = "",
      Key = "󰌋",
      Keyword = "󰌋",
      Method = "󰆧",
      Module = "",
      Namespace = "󰦮",
      Null = "󰟢",
      Number = "",
      Object = "󰅩",
      Operator = "󰆕",
      Package = "󰏖",
      Property = "󰜢",
      Reference = "󰈇",
      Snippet = "",
      String = "󰉿",
      Struct = "󰙅",
      TypeParameter = "",
      Unit = "󰑭",
      Value = "󰎠",
      Variable = "󰀫",
    },

    -- Modern status configuration
    status = {
      -- Enhanced component styling
      style = {
        border = "rounded",
        padding = 1,
        separators = {
          left = { "", "" }, -- Modern powerline separators
          right = { "", "" },
        },
      },

      -- Custom component colors
      colors = {
        git_branch_fg = "#89b4fa",
        git_added = "#a6e3a1",
        git_changed = "#f9e2af",
        git_removed = "#f38ba8",
        lsp_progress_fg = "#cba6f7",
        lsp_client_fg = "#89dceb",
        diagnostics_error_fg = "#f38ba8",
        diagnostics_warn_fg = "#fab387",
        diagnostics_info_fg = "#89dceb",
        diagnostics_hint_fg = "#94e2d5",
        mode_normal_fg = "#89b4fa",
        mode_insert_fg = "#a6e3a1",
        mode_visual_fg = "#cba6f7",
        mode_replace_fg = "#f38ba8",
        mode_command_fg = "#f9e2af",
      },
    },
  },
}
