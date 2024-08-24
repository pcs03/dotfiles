return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "windwp/nvim-ts-autotag",
        },
        config = function()
            local treesitter = require("nvim-treesitter.configs")

            treesitter.setup({
                -- Syntax highlighting
                highlight = {
                    enable = true,
                    disable = {
                        "latex",
                    },
                },
                -- Indendation
                indent = {
                    enable = true,
                },
                -- Autotagging
                autotag = {
                    enable = true,
                },
                -- Ensure installed language parsers
                ensure_installed = {
                    "json",
                    "javascript",
                    "typescript",
                    "tsx",
                    "html",
                    "yaml",
                    "css",
                    "markdown",
                    "markdown_inline",
                    "bash",
                    "lua",
                    "vim",
                    "dockerfile",
                    "gitignore",
                    "query",
                    "python",
                    "c",
                    "cpp",
                    "c_sharp",
                    "cmake",
                    "csv",
                    "latex",
                    "rust",
                    "scss",
                    "sql",
                    "toml",
                    "bibtex",
                    "latex"
                },
                
                -- Auto install missing parsers
                auto_install = true,

                -- Commenting jsx and tsx
                context_commentstring = {
                    enable = true,
                    enable_autocmd = false,
                },
            })
        end
    }
}
