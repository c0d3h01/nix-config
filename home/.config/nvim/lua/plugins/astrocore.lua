---@type LazySpec
return {
  "AstroNvim/astrocore",
  opts = function(_, opts)
    -- OPTIONS (merge)
    opts.options = opts.options or {}
    opts.options.opt = vim.tbl_deep_extend("force", opts.options.opt or {}, {
      number = true,
      relativenumber = true,
      cursorline = true,
      cursorlineopt = "number",
      signcolumn = "yes",
      wrap = false,
      termguicolors = true,
      splitbelow = true,
      splitright = true,
      timeoutlen = 400,
      updatetime = 200,
      undofile = true,
      swapfile = false,
      backup = false,
      writebackup = false,
      clipboard = "unnamedplus",
      ignorecase = true,
      smartcase = true,
      incsearch = true,
      hlsearch = true,
      scrolloff = 6,
      sidescrolloff = 8,
      expandtab = true,
      shiftwidth = 2,
      tabstop = 2,
      smartindent = true,
      list = true,
      listchars = { tab = "» ", trail = "·", extends = "›", precedes = "‹", nbsp = "␣" },
      fillchars = { vert = "│", fold = " ", eob = " ", msgsep = "─", diff = "╱" },
      foldmethod = "expr",
      foldexpr = "nvim_treesitter#foldexpr()",
      foldlevel = 99,
      foldlevelstart = 99,
      foldenable = true,
    })

    opts.features = vim.tbl_deep_extend("force", opts.features or {}, {
      large_buf = { size = 1024 * 512, lines = 20000 },
      autopairs = true,
      cmp = true,
      diagnostics = { virtual_text = true, virtual_lines = false },
      highlighturl = true,
      notifications = true,
    })

    -- MAPPINGS (extend)
    opts.mappings = opts.mappings or {}
    opts.mappings.n = opts.mappings.n or {}
    local maps = opts.mappings.n

    -- Helper to only add if absent (avoid overriding user or core updates)
    local function map_once(lhs, rhs)
      if not maps[lhs] then maps[lhs] = rhs end
    end

    -- Buffer navigation
    map_once("]b", { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" })
    map_once("[b", { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" })

    map_once("<Leader>bd", {
      function()
        require("astroui.status.heirline").buffer_picker(function(bufnr)
          require("astrocore.buffer").close(bufnr)
        end)
      end,
      desc = "Close buffer (picker)",
    })

    map_once("<Leader>bb", { "<Cmd>enew<CR>", desc = "New empty buffer" })
    map_once("<Leader>bo", {
      function()
        local current = vim.api.nvim_get_current_buf()
        for _, b in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_loaded(b) and b ~= current and vim.bo[b].buflisted then
            pcall(vim.api.nvim_buf_delete, b, { force = false })
          end
        end
      end,
      desc = "Close other buffers",
    })

    map_once("<Leader>w", { "<Cmd>w<CR>", desc = "Write buffer" })
    map_once("<Leader>q", { "<Cmd>q<CR>", desc = "Quit window" })
    map_once("<Leader>Q", { "<Cmd>qa<CR>", desc = "Quit all" })

    map_once("<Leader>ut", { "<Cmd>set invrelativenumber<CR>", desc = "Toggle relative number" })
    map_once("<Leader>us", {
      function()
        vim.o.spell = not vim.o.spell
        vim.notify("Spell: " .. (vim.o.spell and "ON" or "OFF"))
      end,
      desc = "Toggle spell",
    })
    map_once("<Leader>ud", {
      function()
        local vt = vim.diagnostic.config().virtual_text
        vim.diagnostic.config { virtual_text = not vt }
        vim.notify("Virtual text: " .. (vt and "OFF" or "ON"))
      end,
      desc = "Toggle diagnostic virtual text",
    })
    map_once("<Leader>ul", {
      function()
        local vl = vim.diagnostic.config().virtual_lines
        vim.diagnostic.config { virtual_lines = not vl }
        vim.notify("Virtual lines: " .. (vl and "OFF" or "ON"))
      end,
      desc = "Toggle diagnostic virtual lines",
    })

    map_once("<C-h>", { "<C-w>h", desc = "Window left" })
    map_once("<C-j>", { "<C-w>j", desc = "Window down" })
    map_once("<C-k>", { "<C-w>k", desc = "Window up" })
    map_once("<C-l>", { "<C-w>l", desc = "Window right" })
    map_once("<A-Left>",  { "<Cmd>vertical resize -4<CR>", desc = "Resize narrower" })
    map_once("<A-Right>", { "<Cmd>vertical resize +4<CR>", desc = "Resize wider" })
    map_once("<A-Up>",    { "<Cmd>resize +2<CR>", desc = "Resize taller" })
    map_once("<A-Down>",  { "<Cmd>resize -2<CR>", desc = "Resize shorter" })

    map_once("<Esc>", { "<Cmd>nohlsearch<CR><Esc>", desc = "Clear search highlight" })
    map_once("j", { function() return vim.v.count == 0 and "gj" or "j" end, expr = true, desc = "Down (wrap aware)" })
    map_once("k", { function() return vim.v.count == 0 and "gk" or "k" end, expr = true, desc = "Up (wrap aware)" })

    map_once("[d", { function() vim.diagnostic.goto_prev({ float = false }) end, desc = "Prev diagnostic" })
    map_once("]d", { function() vim.diagnostic.goto_next({ float = false }) end, desc = "Next diagnostic" })
    map_once("<Leader>e", { function() vim.diagnostic.open_float(nil, { focus = false }) end, desc = "Line diagnostics" })

    map_once("<Leader>lc", { "<Cmd>lopen<CR>", desc = "Open location list" })
    map_once("<Leader>lq", { "<Cmd>lclose<CR>", desc = "Close location list" })
    map_once("<Leader>cq", { "<Cmd>copen<CR>", desc = "Open quickfix" })
    map_once("<Leader>cc", { "<Cmd>cclose<CR>", desc = "Close quickfix" })

    map_once("zr", { "zr", desc = "Open more folds" })
    map_once("zm", { "zm", desc = "Close more folds" })
    map_once("zR", { "zR", desc = "Open all folds" })
    map_once("zM", { "zM", desc = "Close all folds" })

    -- Clipboard (keep separate from find group)
    map_once("<Leader>y", { '"+y', desc = "Yank to system clipboard" })
    map_once("<Leader>p", { '"+p', desc = "Paste from system clipboard" })

    -- Add/restore group descriptors if not present
    if not maps["<Leader>b"] then maps["<Leader>b"] = { desc = "Buffers" } end
    if not maps["<Leader>f"] then maps["<Leader>f"] = { desc = "Find" } end
    if not maps["<Leader>u"] then maps["<Leader>u"] = { desc = "UI Toggles" } end

    -- Visual mode additions
    opts.mappings.v = opts.mappings.v or {}
    if not opts.mappings.v["<Leader>y"] then
      opts.mappings.v["<Leader>y"] = { '"+y', desc = "Yank to system clipboard" }
    end
    if not opts.mappings.v["<Leader>p"] then
      opts.mappings.v["<Leader>p"] = { '"+p', desc = "Paste from system clipboard" }
    end
    if not opts.mappings.v[">"] then
      opts.mappings.v[">"] = { ">gv", desc = "Indent and reselect" }
    end
    if not opts.mappings.v["<"] then
      opts.mappings.v["<"] = { "<gv", desc = "Outdent and reselect" }
    end

    -- Insert mode quick escape
    opts.mappings.i = opts.mappings.i or {}
    if not opts.mappings.i["jk"] then
      opts.mappings.i["jk"] = { "<Esc>", desc = "Exit insert mode" }
    end

    -- Autocmds
    opts.autocmds = opts.autocmds or {}
    opts.autocmds.yank_highlight = opts.autocmds.yank_highlight or {
      {
        event = "TextYankPost",
        desc = "Highlight yanked text",
        callback = function() vim.highlight.on_yank { higroup = "IncSearch", timeout = 120 } end,
      },
    }
    opts.autocmds.trim_trailing_ws = opts.autocmds.trim_trailing_ws or {
      {
        event = "BufWritePre",
        desc = "Trim trailing whitespace",
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          if ft ~= "markdown" and ft ~= "diff" and ft ~= "gitcommit" then
            local view = vim.fn.winsaveview()
            vim.cmd([[silent! %s/\s\+$//e]])
            vim.fn.winrestview(view)
          end
        end,
      },
    }
    opts.autocmds.auto_create_dir = opts.autocmds.auto_create_dir or {
      {
        event = "BufWritePre",
        desc = "Auto create dir",
        callback = function(event)
          local file = event.match
            if file:match("^%w%w+://") then return end
          local dir = vim.fn.fnamemodify(file, ":p:h")
          if not vim.loop.fs_stat(dir) then vim.fn.mkdir(dir, "p") end
        end,
      },
    }

    return opts
  end,
}