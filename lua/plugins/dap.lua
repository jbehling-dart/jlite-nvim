-- lua/plugins/dap.lua
return {
  -- Core DAP support
  {
    "mfussenegger/nvim-dap",
    keys = {
      -- lazy-load on your debug keys
      { "n", "n", desc = "GDB: next (step over)" },
      { "n", "s", desc = "GDB: step (step into)" },
      { "n", "f", desc = "GDB: finish (step out)" },
      { "n", "c", desc = "GDB: continue" },
      { "n", "b", desc = "GDB: toggle breakpoint" },
    },
    config = function()
      local dap = require("dap")
      -- GDB-style shorthands
      vim.keymap.set("n", "n", dap.step_over,         { desc = "GDB: next" })
      vim.keymap.set("n", "s", dap.step_into,         { desc = "GDB: step" })
      vim.keymap.set("n", "f", dap.step_out,          { desc = "GDB: finish" })
      vim.keymap.set("n", "c", dap.continue,          { desc = "GDB: continue" })
      vim.keymap.set("n", "b", dap.toggle_breakpoint, { desc = "GDB: breakpoint" })
      vim.keymap.set("n", "B", function()
        dap.set_breakpoint(vim.fn.input("Condition: "))
      end, { desc = "GDB: conditional breakpoint" })
      vim.keymap.set("n", "p", function()
        dap.repl.open()
        dap.repl.run_command("print " .. vim.fn.expand("<cword>"))
      end, { desc = "GDB: print var" })
      vim.keymap.set("n", "r", dap.run_to_cursor,     { desc = "GDB: run to cursor" })
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
          { type = "go", name = "Debug",        request = "launch", program = "${file}" },
          { type = "go", name = "Debug test",   request = "launch", mode    = "test", program = "${file}" },
          { type = "go", name = "Debug test (mod)", request = "launch", mode = "test", program = "./${relativeFileDirname}" },
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

