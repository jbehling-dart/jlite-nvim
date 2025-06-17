local keymaps = require("config.keymaps") -- path to your keymap module

return {
  -- Mason: Manages installation of LSP servers and other development tools
  {
    "williamboman/mason.nvim",
    config = true,
  },

  -- mason-lspconfig: Connects Mason with the Neovim LSP client
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        -- These LSP servers will be installed automatically by Mason
        ensure_installed = {
          "pyright",         -- Python
          "clangd",          -- C and C++
          "vhdl_ls",         -- VHDL
          "lua_ls",          -- Lua (Neovim development)
          "rust_analyzer",   -- Rust
          "cmake",           -- CMake build files
          "bashls",          -- Bash shell scripting
          "vimls",           -- Vim
          "marksman",        -- Markdown
        },
        automatic_installation = true,
      })
    end,
  },

  -- nvim-lspconfig: Main plugin for configuring built-in Neovim LSP client
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")

      -- Capabilities are used to enable autocompletion support via nvim-cmp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Configuration for each language server
      local servers = {
        pyright = {},       -- Python
        clangd = {},        -- C and C++
        vhdl_ls = {},       -- VHDL
        rust_analyzer = {}, -- Rust
        cmake = {},         -- CMake
        bashls = {},        -- Bash
        marksman = {},      -- Markdown

        -- Custom configuration for Lua LSP used in Neovim development
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" }, -- Prevent warnings about the global 'vim' variable
              },
              workspace = {
                checkThirdParty = false, -- Disable prompt for workspace config
              },
              telemetry = {
                enable = false, -- Disable data collection
              },
            },
          },
        },
      }

      -- Loop through each server and apply setup
      for name, config in pairs(servers) do
        config.capabilities = capabilities
        config.on_attach = keymaps.lsp_on_attach
        lspconfig[name].setup(config)
      end
    end,
  },
}
