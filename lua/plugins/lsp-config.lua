local keymaps      = require("config.keymaps")

return {
  -- Core LSP client
  { "neovim/nvim-lspconfig" },

  -- Mason: Manages installation of LSP servers and other development tools
  { "williamboman/mason.nvim", config = true },

  -- Connects Mason with the Neovim LSP client
  { "williamboman/mason-lspconfig.nvim",
    version = "*",
    dependencies = { "mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      -- 1) Install Mason itself
      require("mason").setup()
      -- 2) Configure Mason to install LSP server binaries
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",        -- Python LSP
          "clangd",         -- C/C++ LSP
          "vhdl_ls",        -- VHDL LSP
          "lua_ls",         -- Lua LSP
          "rust_analyzer",  -- Rust LSP
          "cmake",          -- CMake LSP
          "bashls",         -- Bash LSP
          "vimls",          -- Vimscript LSP
          "marksman",       -- Markdown LSP
          "texlab",         -- LaTeX LSP
          "gopls",          -- Go LSP
        },
        automatic_installation = false,  -- disable deprecated framework-based setup
      })

      -- 3) Prepare capabilities and per-server overrides
      -- Use the new API: vim.lsp.config replaces the deprecated framework
      local lspconfig = require("lspconfig")
      --local lspconfig = vim.lsp.config
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local srv_overrides = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace   = { checkThirdParty = false },
              telemetry   = { enable = false },
            },
          },
        },
        gopls = {
          settings = {
            gopls = {
              analyses    = { unusedparams = true, unreachable = true },
              staticcheck = true,
            },
          },
        },
      }

      -- 4) Manually set up each LSP server
      local servers = {
        "pyright", "clangd", "vhdl_ls", "lua_ls", "rust_analyzer",
        "cmake",   "bashls",  "vimls",    "marksman",   "texlab",   "gopls",
      }
      for _, name in ipairs(servers) do
        local opts = {
          on_attach    = keymaps.lsp_on_attach,
          capabilities = capabilities,
        }
        if srv_overrides[name] then
          opts = vim.tbl_deep_extend("force", opts, srv_overrides[name])
        end
        lspconfig[name].setup(opts)
      end
    end,
  },
}

