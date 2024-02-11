return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { "buffers" },
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
            },
        },
        config = function()
            local theme = require("lualine.themes.auto")
            theme.normal.c.bg = "None"
            theme.inactive.c.bg = "None"
            require("lualine").setup {
                options = {
                    theme = theme
                },
            }
        end
    },
}
