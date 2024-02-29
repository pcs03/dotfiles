return {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
        local nls = require("null-ls")
        local formatting = nls.builtins.formatting
        local diagnostics = nls.builtins.diagnostics
        local actions = nls.builtins.code_actions

        opts.sources = vim.list_extend(opts.sources or {}, {
            -- Lua
            formatting.stylua,

            -- Python
            formatting.black,
            formatting.black.with({
                extra_args = { "--preview", "--line-length", "120"}
            }),
            formatting.isort,
            diagnostics.ruff,

            -- JS / TS
            formatting.prettierd,
            diagnostics.eslint_d,
            actions.eslint_d,

            -- LaTeX
            formatting.latexindent,

        })
        return opts
    end,
}
