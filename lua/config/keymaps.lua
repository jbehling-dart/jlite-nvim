-- Telescope keybindings
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Grep files" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "List buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })

-- nvim tree
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })

-- keymaps.lua
local M = {}

M.nvim_tree_on_attach = function(bufnr)
  local api = require("nvim-tree.api")
  local node = require("nvim-tree.api").tree.get_node_under_cursor()
 
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- Custom keybindings
  vim.keymap.set("n", "<CR>", function()
    local node = require("nvim-tree.api").tree.get_node_under_cursor()
    if node.type == "directory" or node.type == "unknown" then
      require("nvim-tree.api").node.open.edit()
    else
      require("nvim-tree.api").node.open.tab()
    end
  end, opts("Expand dir or open in new tab"))
  vim.keymap.set("n", "s", require("nvim-tree.api").node.open.horizontal, opts("Open in horizontal split"))
  vim.keymap.set("n", "v", require("nvim-tree.api").node.open.vertical, opts("Open in vertical split"))
end

return M
