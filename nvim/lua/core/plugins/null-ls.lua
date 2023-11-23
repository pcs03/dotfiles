return {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
        local nls = require("null-ls")
        local formatting = nls.builtins.formatting
        local diagnostics = nls.builtins.diagnostics

        opts.sources = vim.list_extend(opts.sources or {}, {
            -- Lua
            formatting.stylua,

            -- Python
            formatting.black,
            formatting.black.with({
                extra_args = { "--preview", "--line-length", "120"}
            }),
            diagnostics.ruff,
        })
        return opts
    end,
}
