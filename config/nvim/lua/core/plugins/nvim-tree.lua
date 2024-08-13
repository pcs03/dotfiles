return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local nvimtree = require("nvim-tree")

        -- Settings from documentation
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- Change color of tree arrows
        vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

        -- configure tree
        nvimtree.setup({
            view = {
                width = 35,
                relativenumber = true,
            },

            -- Change folder arrow icons
            renderer = {
                indent_markers = {
                    enable = true,
                },
                icons = {
                    glyphs = {
                        folder = {
                          arrow_closed = "", -- arrow when folder is closed
                          arrow_open = "", -- arrow when folder is open
                        },
                    },
                },
            },

            actions = {
                open_file = {
                    window_picker = {
                        enable = false,
                    },
                },
            },
            filters = {
                custom = { ".DS_Store" },
            },
            git = {
                ignore = false,
            },
        })

        local keymap = vim.keymap

        keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
    end
}
