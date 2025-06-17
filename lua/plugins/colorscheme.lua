--return {
--  {
--    "sainnhe/everforest",
--    priority = 1000,
--    config = function()
--      -- Optional: Configure background/darkness variant
--      vim.g.everforest_background = "hard"   -- "soft", "medium", or "hard"
--      vim.g.everforest_enable_italic = 1
--      vim.g.everforest_disable_italic_comment = 0
--
--      -- Required: set colorscheme
--      vim.cmd.colorscheme("everforest")
--    end,
--  }
--}

return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("catppuccin")
        end
    }
}
