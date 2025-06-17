-- Telescope keybindings
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Grep files" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "List buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })

