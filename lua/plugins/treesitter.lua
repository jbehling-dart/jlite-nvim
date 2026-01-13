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
            -- Tell Treesitter about the LaTeX grammar and map it to filetype "tex"
            local parsers = require("nvim-treesitter.parsers").get_parser_configs()
            -- RISC-V ASM grammar
            parsers.riscv = {
                install_info = {
                    url = "https://github.com/erihsu/tree-sitter-riscvasm",
                    files = { "src/parser.c" },
                    branch = "main",
                },
                filetype = "riscv",
            }

            -- ARM/Thumb ASM grammar
            parsers.arm = {
                install_info = {
                    url = "https://github.com/SethBarberee/tree-sitter-asm",
                    files = { "src/parser.c" },
                    branch = "master",
                },
                filetype = "arm",
            }
            -- configure
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "lua"
                    ,"python"
                    ,"bash"
                    ,"c"
                    ,"cpp"
                    ,"go"
                    ,"vim"
                    ,"markdown"
                    ,"vhdl"
                    --,"latex"
                    ,"nasm"
                    ,"riscv"
                    ,"arm"

                },
                highlight = {
                    enable = true,
                    -- optional: keep Vim’s regex highlight for things Tree-Sitter misses
                    -- additional_vim_regex_highlighting = { "arm", "tex" },
                },
                indent = { enable = true }
            })
        end
    }
}
