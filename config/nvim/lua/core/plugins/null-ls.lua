return {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
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

            -- JS / TS
            formatting.prettierd,

            -- LaTeX

            -- C++
            formatting.clang_format,

            -- GO
            formatting.gofmt,
            formatting.goimports,

        })
        return opts
    end,
}
