return {
    "theprimeagen/harpoon",
    config = function()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")
        local keymap = vim.keymap

        keymap.set("n", "<leader>a", mark.add_file, { desc = "Add file to Harpoon" })
        keymap.set("n", "<leader>d", ui.toggle_quick_menu, { desc = "Toggle Harpoon" })

        keymap.set("n", "<leader>fj", function() ui.nav_file(1) end, { desc = "Go to Harpoon 1" })
        keymap.set("n", "<leader>fk", function() ui.nav_file(2) end, { desc = "Go to Harpoon 2" })
        keymap.set("n", "<leader>fl", function() ui.nav_file(3) end, { desc = "Go to Harpoon 3" })
        keymap.set("n", "<leader>f;", function() ui.nav_file(4) end, { desc = "Go to Harpoon 4" })
    end,
}
