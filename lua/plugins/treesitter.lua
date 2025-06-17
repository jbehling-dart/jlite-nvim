return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = 'master',
        lazy = 'false',
        build = ":TSUpdate",
        event = {"BufReadPost","BufNewFile"},
        config = function()
            -- Prefer git over curl
            require("nvim-treesitter.install").prefer_git = true
            -- configure
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "python", "bash", "c", "cpp", "vim", "markdown", "vhdl" },
                highlight = { enable = true },
                indent = { enable = true }
            })
        end
    }
}
