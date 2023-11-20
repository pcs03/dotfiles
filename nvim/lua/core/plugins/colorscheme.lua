return {
    "folke/tokyonight.nvim",
    "rose-pine/neovim",
    "rebelot/kanagawa.nvim",
    {
        "catppuccin/nvim",
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme catppuccin]])
        end,
    }
}

