-- lua/plugins/nvim-tree.lua
local keymaps = require("config.keymaps") -- path to your keymap module

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeClose" },
  config = function()
    require("nvim-tree").setup({
      on_attach = keymaps.nvim_tree_on_attach,
      actions = {
        open_file = {
          quit_on_open = false,
          resize_window = false,
        },
      },
      renderer = {
        highlight_git = true,
        icons = {
          show = {
            git = true,
            folder = true,
            file = true,
            folder_arrow = true,
          },
        },
      },
      git = {
        enable = true,
        ignore = false,
      },
    })
  end,
}
