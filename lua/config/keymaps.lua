-- Telescope keybindings
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Grep files" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "List buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })

-- nvim tree
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })

-- GLOBAL LSP & DIAGNOSTIC KEYMAPS (always available)
-- Put this at top-level in your keymaps.lua (outside any on_attach)

local global_opts = { noremap = true, silent = true, nowait = true }

-- Core LSP actions (calls through lsp if available; safe when no client attached)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, global_opts)
vim.keymap.set("n", "K", vim.lsp.buf.hover, global_opts)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, global_opts)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, global_opts)
vim.keymap.set("n", "gr", vim.lsp.buf.references, global_opts)
vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, global_opts)

-- Diagnostics: next / prev
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, global_opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, global_opts)

-- Show diagnostic under cursor (global)
vim.keymap.set("n", "<leader>dd", function()
  vim.diagnostic.open_float(nil, { scope = "cursor" })
end, global_opts)

-- Put diagnostics into location list or quickfix (global)
vim.keymap.set("n", "<leader>dl", function()
  vim.diagnostic.setloclist({ open = true })
end, global_opts)

vim.keymap.set("n", "<leader>dq", function()
  vim.diagnostic.setqflist({ open = true })
end, global_opts)

-- Toggle virtual text globally (inline error messages)
-- stores state in a global so it persists across buffers
_G.diagnostic_virtual_text = _G.diagnostic_virtual_text == nil and true or _G.diagnostic_virtual_text
vim.keymap.set("n", "<leader>dt", function()
  _G.diagnostic_virtual_text = not _G.diagnostic_virtual_text
  vim.diagnostic.config({ virtual_text = _G.diagnostic_virtual_text })
  local msg = _G.diagnostic_virtual_text and "enabled" or "disabled"
  vim.notify("Diagnostic virtual_text " .. msg, vim.log.levels.INFO)
end, global_opts)

-- Optional: open diagnostic float on CursorHold globally (non-focus)
-- NOTE: can be noisy; uncomment if you like this behaviour
-- vim.api.nvim_create_autocmd("CursorHold", {
--   callback = function()
--     vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
--   end,
--})

-- If you previously created buffer-local mappings inside on_attach, you can either:
-- 1) remove or comment those lines (preferred to avoid duplicate mapping definitions), or
-- 2) leave them (they will be ignored because global mapping already exists).


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

--  -- lsp functions
--  -- LSP keymaps: Set up when an LSP attaches to a buffer
--  m.lsp_on_attach = function(client, bufnr)
--    print(" LSP on_attach fired for " .. client.name)
--    -- Options used for all mappings: 
--    -- 'buffer' makes the mapping local to the current LSP-attached buffer
--    -- 'silent' and 'noremap' are standard good practices
--    local opts = { buffer = bufnr, silent = true, noremap = true, nowait = true }
--  
--    -- existing useful LSP maps
--    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
--    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
--    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
--    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
--    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
--    vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)
--  
--    -- diagnostics: navigation and actions
--    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
--    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
--  
--    -- open a floating window with diagnostics under cursor (useful for quick details)
--    vim.keymap.set("n", "<leader>dd", function()
--      vim.diagnostic.open_float(nil, { scope = "cursor" })
--    end, opts)
--  
--    -- put diagnostics into location list or quickfix
--    vim.keymap.set("n", "<leader>dl", function() vim.diagnostic.setloclist({ open = true }) end, opts)
--    vim.keymap.set("n", "<leader>dq", function() vim.diagnostic.setqflist({ open = true }) end, opts)
--  
--    -- Toggle virtual text (inline underlines/messages)
--    do
--      local vt = vim.b[bufnr].diagnostic_virtual_text
--      if vt == nil then vim.b[bufnr].diagnostic_virtual_text = true end
--      vim.keymap.set("n", "<leader>dt", function()
--        vim.b[bufnr].diagnostic_virtual_text = not vim.b[bufnr].diagnostic_virtual_text
--        vim.diagnostic.config({ virtual_text = vim.b[bufnr].diagnostic_virtual_text })
--        local ok, _ = pcall(vim.api.nvim_buf_set_var, bufnr, "diagnostic_virtual_text", vim.b[bufnr].diagnostic_virtual_text)
--        -- no-op on failure; this keeps state per-buffer when possible
--      end, opts)
--    end
--  
--    -- show diagnostic float on CursorHold (buffer-local, non-focus)
--    -- set updatetime in your init.lua if you want faster response (e.g. vim.o.updatetime = 250)
--    vim.api.nvim_create_autocmd("CursorHold", {
--      buffer = bufnr,
--      callback = function()
--        -- don't steal focus, opens only when there's a diagnostic for the cursor
--        local ok, _ = pcall(function()
--          vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
--        end)
--      end,
--    })
--  end


return M

