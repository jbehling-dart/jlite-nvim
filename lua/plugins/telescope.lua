return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      local open_in_tab = function(prompt_bufnr)
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.cmd("tabedit " .. vim.fn.fnameescape(entry.path or entry.filename))
      end

      local open_in_split = function(prompt_bufnr)
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.cmd("split " .. vim.fn.fnameescape(entry.path or entry.filename))
      end

      local open_in_vsplit = function(prompt_bufnr)
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.cmd("vsplit " .. vim.fn.fnameescape(entry.path or entry.filename))
      end

      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<CR>"] = open_in_tab,
              ["<C-s>"] = open_in_split,
              ["<C-v>"] = open_in_vsplit,
            },
            n = {
              ["<CR>"] = open_in_tab,
              ["<C-s>"] = open_in_split,
              ["<C-v>"] = open_in_vsplit,
            },
          },
        },
      })
    end
  }
}
--  return {
--      {
--          "nvim-telescope/telescope.nvim",
--          dependencies = { "nvim-lua/plenary.nvim" },
--          config = function()
--  
--              require("telescope").setup()
--          end
--      }
--  }
