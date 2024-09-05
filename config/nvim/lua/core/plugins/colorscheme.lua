return {
    "catppuccin/nvim",
    priority = 1000,
    config = function()
        local cat = require("catppuccin")
        cat.options.transparent_background = true
        cat.compile()
        vim.cmd([[colorscheme catppuccin]])
    end,
}

