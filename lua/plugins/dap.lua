return {
  -- Core DAP support
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",  -- load DAP on demand (you can pick a better trigger if you like)
    config = function()
      local dap = require("dap")

      -- Only set these keymaps once a session starts
      dap.listeners.after.event_initialized["custom_dap_mappings"] = function(session, body)
        local bufnr = vim.api.nvim_get_current_buf()

        -- GDB-style shorthands, buffer-local
        vim.keymap.set("n", "n", dap.step_over,         { desc = "GDB: next",         buffer = bufnr })
        vim.keymap.set("n", "s", dap.step_into,         { desc = "GDB: step",         buffer = bufnr })
        vim.keymap.set("n", "f", dap.step_out,          { desc = "GDB: finish",       buffer = bufnr })
        vim.keymap.set("n", "c", dap.continue,          { desc = "GDB: continue",     buffer = bufnr })
        vim.keymap.set("n", "b", dap.toggle_breakpoint, { desc = "GDB: breakpoint",   buffer = bufnr })
        vim.keymap.set("n", "B", function()             -- conditional
          dap.set_breakpoint(vim.fn.input("Condition: "))
        end, { desc = "GDB: cond. breakpoint", buffer = bufnr })
        vim.keymap.set("n", "r", dap.run_to_cursor,     { desc = "GDB: run to cursor", buffer = bufnr })

        -- Print under cursor
        vim.keymap.set("n", "p", function()
          dap.repl.open()
          dap.repl.run_command("print " .. vim.fn.expand("<cword>"))
        end, { desc = "GDB: print var", buffer = bufnr })
      end

      -- Optional: clear mappings on exit
      for _, ev in ipairs({ "event_terminated", "event_exited" }) do
        dap.listeners.before[ev]["custom_dap_mappings"] = function()
          local bufnr = vim.api.nvim_get_current_buf()
          for _, k in ipairs({ "n", "s", "f", "c", "b", "B", "r", "p" }) do
            pcall(vim.api.nvim_buf_del_keymap, bufnr, "n", k)
          end
        end
      end
    end,
  },

  -- Go-specific DAP adapter + configs
  {
    "leoluz/nvim-dap-go",
    dependencies = { "mfussenegger/nvim-dap" },
    ft = { "go", "gomod" },
    config = function()
      require("dap-go").setup({
        delve = { path = "dlv", port = "38697" },
        dap_configurations = {
          { type = "go", name = "Debug",           request = "launch", program = "${file}" },
          { type = "go", name = "Debug test",      request = "launch", mode = "test", program = "${file}" },
          { type = "go", name = "Debug test (mod)",request = "launch", mode = "test", program = "./${relativeFileDirname}" },
        },
      })
    end,
  },

  -- nvim-nio: required by the latest nvim-dap-ui
  {
    "nvim-neotest/nvim-nio",
    lazy = true,
  },

  -- UI for DAP (requires nvim-nio)
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui"]      = function() dapui.close() end
    end,
  },
}

