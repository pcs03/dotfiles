return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v3.x",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"neovim/nvim-lspconfig",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local lsp = require("lsp-zero")
		lsp.preset("recommended")

		lsp.setup_servers({})

		local cmp = require("cmp")
		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			sources = {
				{ name = "nvim_lsp" },
				{ name = "path" },
				{ name = "luasnip" },
				{ name = "buffer" },
			},
			formatting = lsp.cmp_format(),
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.complete(),
				["<Tab>"] = cmp.mapping.confirm({ select = true }),
			}),
		})

		lsp.set_sign_icons({
			error = " ",
			warn = " ",
			hint = "󰠠 ",
			info = " ",
		})

		lsp.on_attach(function(client, bufnr)
			local opts = { buffer = bufnr, remap = false }
			local keymap = vim.keymap

			opts.desc = "Show LSP definition"
			keymap.set("n", "gd", vim.lsp.buf.definition, opts)

			opts.desc = "Show documentation under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts)

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

			opts.desc = "Format document"
			keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)

            opts.desc = "Show code actions"
            keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

            opts.desc = "Show diagnostics"
            keymap.set("n", "gl", vim.diagnostic.open_float, opts)
		end)

		require("mason").setup({})
		require("mason-lspconfig").setup({
			ensure_installed = {
				"tsserver",
				"html",
				"cssls",
				"tailwindcss",
				"lua_ls",
				"emmet_ls",
				"pyright",
				"arduino_language_server",
				"clangd",
				"bashls",
				"cmake",
				"dockerls",
				"docker_compose_language_service",
				"eslint",
				"jsonls",
				"rust_analyzer",
				"sqlls",
			},
			handlers = {
				lsp.default_setup,
				lua_ls = function()
					local lua_opts = lsp.nvim_lua_ls()
					require("lspconfig").lua_ls.setup(lua_opts)
				end,
			},
		})
	end,
}
