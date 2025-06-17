return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("ibl").setup({
        scope = { enabled = true },
        indent = { char = "│" },  -- you can use "┊", "¦", "⎸", etc.
      })
    end,
  },
}
