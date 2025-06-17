-- Telescope keybindings
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Grep files" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "List buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })

-- nvim tree
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })

-- keymaps.lua
local M = {}

-- nvim-tree - open, navigate and add
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
  vim.keymap.set("n", "a", require("nvim-tree.api").fs.create, {
    desc = "nvim-tree: Create file or dir",
    buffer = bufnr,
    noremap = true,
    silent = true,
    nowait = true,
  })
end

-- lsp functions
-- LSP keymaps: Set up when an LSP attaches to a buffer
M.lsp_on_attach = function(client, bufnr)
  print(" LSP on_attach fired for " .. client.name)
  -- Options used for all mappings: 
  -- 'buffer' makes the mapping local to the current LSP-attached buffer
  -- 'silent' and 'noremap' are standard good practices
  local opts = { buffer = bufnr, silent = true, noremap = true, nowait=true }

  -- 'gd' Go to definition of the symbol under the cursor
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

  -- 'K' Show documentation in a floating window for the symbol under the cursor
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

  -- '<leader>rn' Rename all references of the symbol under the cursor
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

  -- '<leader>ca' Show code actions (e.g., quick fixes, refactors)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

  -- 'gr' List all references to the symbol under the cursor
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

  -- '<leader>f' Format the current buffer using LSP
  -- Uses async formatting to avoid blocking the UI
  vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, opts)
end

return M

