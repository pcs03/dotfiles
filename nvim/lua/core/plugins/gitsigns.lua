return {
    "lewis6991/gitsigns.nvim",
    opts = {
        signs = {
            add          = { text = '', hl = "GitSignsAdd", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
            change       = { text = '', hl = "GitSignsChange", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
            delete       = { text = '', hl = "GitSignsDelete", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
            topdelete    = { text = '󱅁', hl = "GitSignsDelete", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
            changedelete = { text = '󰍷', hl = "GitSignsChange", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
            follow_files = true
        },
        attach_to_untracked = true,
        current_line_blame = false,
        current_line_blame_opts = {
            virt_text = true,
            virt_text_position = "eol",
            delay = 1000,
            ignore_whitespace = false,
            virt_text_priority = 100,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 10000,
        preview_config = {
            border = "single",
            style = "minimal",
            relative = "cursor",
            row = 0,
            col = 1,
        },
        yadm = {
            enable = false
        },
        on_attach = function(bufnr)
            local gs = require("gitsigns")

            local function keymap(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            keymap("n", "<leader>hp", gs.preview_hunk)
        end,
    },
}
