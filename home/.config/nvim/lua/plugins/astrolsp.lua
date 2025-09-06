---@type LazySpec
return {
  "AstroNvim/astrolsp",
  dependencies = {
    { "b0o/SchemaStore.nvim", version = false },
  },
  opts = function(_, opts)
    -- Merge feature toggles
    opts.features = vim.tbl_deep_extend("force", opts.features or {}, {
      codelens = false,
      inlay_hints = false,
      semantic_tokens = false,
    })

    -- Formatting settings
    opts.formatting = vim.tbl_deep_extend("force", opts.formatting or {}, {
      format_on_save = {
        enabled = true,
        allow_filetypes = {},
        ignore_filetypes = { "markdown" },
      },
      timeout_ms = 1500,
    })

    -- Ensure a base set of servers (non-destructive)
    local ensure = {
      "lua_ls",
      "pyright",
      "ts_ls",
      "jsonls",
      "bashls",
      "html",
      "cssls",
      "yamlls",
      "marksman",
      "dockerls",
      -- "gopls",
      -- "clangd",
    }
    opts.servers = opts.servers or {}
    local present = {}
    for _, s in ipairs(opts.servers) do present[s] = true end
    for _, s in ipairs(ensure) do if not present[s] then table.insert(opts.servers, s) end end

    -- Helper to safely fetch schemastore schemas
    local function get_schemas(kind)
      local ok, schemastore = pcall(require, "schemastore")
      if not ok then return {} end
      if kind == "json" then
        return schemastore.json.schemas()
      elseif kind == "yaml" then
        return schemastore.yaml.schemas()
      end
      return {}
    end

    -- Merge per-server config as tables (NO functions)
    opts.config = vim.tbl_deep_extend("force", opts.config or {}, {
      lua_ls = {
        settings = {
          Lua = {
            completion = { callSnippet = "Replace" },
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      },
      tsserver = { single_file_support = false },
      gopls = {
        settings = {
          gopls = {
            analyses = { unusedparams = true },
            staticcheck = true,
          },
        },
      },
      jsonls = {
        settings = {
          json = {
            validate = { enable = true },
            schemas = get_schemas("json"),
          },
        },
      },
      yamlls = {
        settings = {
          yaml = {
            keyOrdering = false,
            schemaStore = { enable = false, url = "" }, -- we supply schemas ourselves
            schemas = get_schemas("yaml"),
          },
        },
      },
      -- clangd = { capabilities = { offsetEncoding = "utf-8" } },
    })

    -- Extend mappings instead of replacing
    opts.mappings = opts.mappings or {}
    opts.mappings.n = opts.mappings.n or {}
    opts.mappings.v = opts.mappings.v or {}

    local function map_once(mode, lhs, rhs)
      opts.mappings[mode] = opts.mappings[mode] or {}
      if not opts.mappings[mode][lhs] then opts.mappings[mode][lhs] = rhs end
    end

    map_once("n", "<Leader>lf", {
      function() vim.lsp.buf.format { async = true } end,
      desc = "LSP Format buffer",
    })
    map_once("v", "<Leader>lf", {
      function() vim.lsp.buf.format { async = true } end,
      desc = "LSP Format selection",
    })

    map_once("n", "K",  { function() vim.lsp.buf.hover() end, desc = "LSP Hover" })
    map_once("n", "gd", { function() vim.lsp.buf.definition() end, desc = "Go to definition" })
    map_once("n", "gD", { function() vim.lsp.buf.declaration() end, desc = "Go to declaration", cond = "textDocument/declaration" })
    map_once("n", "gr", { function() vim.lsp.buf.references() end, desc = "References" })
    map_once("n", "gi", { function() vim.lsp.buf.implementation() end, desc = "Go to implementation" })
    map_once("n", "gt", { function() vim.lsp.buf.type_definition() end, desc = "Type definition" })
    map_once("n", "gl", { function() vim.diagnostic.open_float() end, desc = "Line diagnostics" })
    map_once("n", "<Leader>rn", { function() vim.lsp.buf.rename() end, desc = "Rename symbol" })
    map_once("n", "<Leader>ca", { function() vim.lsp.buf.code_action() end, desc = "Code action" })

    map_once("n", "<Leader>uh", {
      function()
        local ih = vim.lsp.inlay_hint
        if ih then
          local enabled = ih.is_enabled and ih.is_enabled(0)
          ih.enable(not enabled, { 0 })
          vim.notify("Inlay hints " .. (enabled and "disabled" or "enabled"))
        end
      end,
      desc = "Toggle Inlay Hints",
    })

    map_once("n", "<Leader>uS", {
      function() require("astrolsp.toggles").buffer_semantic_tokens() end,
      desc = "Toggle semantic tokens (buffer)",
      cond = function(client)
        return client.supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens
      end,
    })

    if not opts.mappings.n["<Leader>l"] then
      opts.mappings.n["<Leader>l"] = { desc = "LSP" }
    end
    if not opts.mappings.n["<Leader>f"] then
      opts.mappings.n["<Leader>f"] = { desc = "Find" }
    end

    -- on_attach wrapper
    local previous_on_attach = opts.on_attach
    opts.on_attach = function(client, bufnr)
      if not opts.features.semantic_tokens and client.server_capabilities.semanticTokensProvider then
        client.server_capabilities.semanticTokensProvider = nil
      end
      vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
      if type(previous_on_attach) == "function" then previous_on_attach(client, bufnr) end
    end

    return opts
  end,
}