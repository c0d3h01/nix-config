---@type LazySpec
return {
  "AstroNvim/astrolsp",
  dependencies = {
    { "b0o/SchemaStore.nvim", version = false },
  },
  opts = function(_, opts)
    -- Merge feature toggles - disable problematic features for stability
    opts.features = vim.tbl_deep_extend("force", opts.features or {}, {
      codelens = true,
      inlay_hints = true,
      semantic_tokens = true, -- Enable but handle safely
    })

    -- Formatting settings
    opts.formatting = vim.tbl_deep_extend("force", opts.formatting or {}, {
      format_on_save = {
        enabled = true,
        allow_filetypes = {},
        ignore_filetypes = { "markdown", "text" },
      },
      timeout_ms = 2000,
      disabled = { "lua_ls" }, -- Let stylua handle Lua formatting
    })

    -- Essential servers only for stability
    opts.servers = {
      "lua_ls",
      "pyright",
      "jsonls",
      "yamlls",
      "bashls",
      "marksman",
    }

    -- Helper to safely get schemas
    local function get_schemas(kind)
      local ok, schemastore = pcall(require, "schemastore")
      if not ok then return {} end
      if kind == "json" and schemastore.json then
        return schemastore.json.schemas()
      elseif kind == "yaml" and schemastore.yaml then
        return schemastore.yaml.schemas()
      end
      return {}
    end

    -- Safe server configurations
    opts.config = {
      lua_ls = {
        settings = {
          Lua = {
            completion = { callSnippet = "Replace" },
            diagnostics = {
              globals = { "vim" },
              disable = { "missing-fields" },
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                "${3rd}/luv/library",
              },
            },
            telemetry = { enable = false },
            format = { enable = false }, -- Use stylua instead
          },
        },
      },
      pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoImportCompletions = true,
            },
          },
        },
      },
      jsonls = {
        settings = {
          json = {
            validate = { enable = true },
            schemas = get_schemas "json",
          },
        },
      },
      yamlls = {
        settings = {
          yaml = {
            keyOrdering = false,
            schemaStore = {
              enable = false,
              url = "",
            },
            schemas = get_schemas "yaml",
          },
        },
      },
      bashls = {
        filetypes = { "sh", "bash", "zsh" },
      },
    }

    -- Safe LSP mappings
    opts.mappings = opts.mappings or {}
    opts.mappings.n = opts.mappings.n or {}

    local function map_once(mode, lhs, rhs)
      opts.mappings[mode] = opts.mappings[mode] or {}
      if not opts.mappings[mode][lhs] then opts.mappings[mode][lhs] = rhs end
    end

    -- Core LSP mappings
    map_once("n", "K", {
      function() vim.lsp.buf.hover() end,
      desc = "LSP Hover",
    })
    map_once("n", "gd", {
      function() vim.lsp.buf.definition() end,
      desc = "Go to definition",
    })
    map_once("n", "gD", {
      function() vim.lsp.buf.declaration() end,
      desc = "Go to declaration",
    })
    map_once("n", "gr", {
      function() vim.lsp.buf.references() end,
      desc = "References",
    })
    map_once("n", "gi", {
      function() vim.lsp.buf.implementation() end,
      desc = "Go to implementation",
    })
    map_once("n", "<Leader>rn", {
      function() vim.lsp.buf.rename() end,
      desc = "Rename symbol",
    })
    map_once("n", "<Leader>ca", {
      function() vim.lsp.buf.code_action() end,
      desc = "Code action",
    })
    map_once("n", "<Leader>lf", {
      function()
        vim.lsp.buf.format {
          async = true,
          timeout_ms = 2000,
        }
      end,
      desc = "Format buffer",
    })

    -- Safe inlay hints toggle
    map_once("n", "<Leader>uh", {
      function()
        if vim.lsp.inlay_hint then
          local current_state = vim.lsp.inlay_hint.is_enabled(0)
          vim.lsp.inlay_hint.enable(not current_state, { 0 })
          vim.notify("Inlay hints " .. (current_state and "disabled" or "enabled"))
        else
          vim.notify "Inlay hints not available"
        end
      end,
      desc = "Toggle Inlay Hints",
    })

    -- Group labels
    if not opts.mappings.n["<Leader>l"] then opts.mappings.n["<Leader>l"] = { desc = "LSP" } end

    -- Safe on_attach function
    local previous_on_attach = opts.on_attach
    opts.on_attach = function(client, bufnr)
      -- Safely handle semantic tokens
      if client.server_capabilities.semanticTokensProvider then
        if not opts.features.semantic_tokens then client.server_capabilities.semanticTokensProvider = nil end
      end

      -- Set buffer options safely
      local success, _ = pcall(vim.api.nvim_buf_set_option, bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
      if not success then
        -- Fallback for newer Neovim versions
        vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
      end

      -- Call previous on_attach if it exists
      if type(previous_on_attach) == "function" then
        local ok, err = pcall(previous_on_attach, client, bufnr)
        if not ok then vim.notify("Error in previous on_attach: " .. tostring(err), vim.log.levels.WARN) end
      end
    end

    return opts
  end,
}
