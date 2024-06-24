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

        local util = require("lspconfig/util")

		lsp.setup_servers({})

		local cmp = require("cmp")
        local cmp_action = require('lsp-zero').cmp_action()
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
                ['<C-b>'] = cmp_action.luasnip_jump_forward(),
                ['<C-f>'] = cmp_action.luasnip_jump_backward(),
			}),
		})

		lsp.set_sign_icons({
			error = " ",
			warn = " ",
			hint = "󰠠 ",
			info = " ",
		})

		lsp.on_attach(function(client, bufnr)
			local opts = { buffer = bufnr}
			local keymap = vim.keymap

			opts.desc = "Show LSP definition"
			keymap.set("n", "gd", vim.lsp.buf.definition, opts)

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

			opts.desc = "Go to implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts)

			opts.desc = "Go to references"
			keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)

			opts.desc = "Go to type definition"
			keymap.set("n", "go", "<cmd>Telescope lsp_type_definitions<cr>", opts)

			opts.desc = "Show signiture information"
			keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)

            opts.desc = "Show diagnostics"
            keymap.set("n", "gl", vim.diagnostic.open_float, opts)

			opts.desc = "Show documentation under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts)

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

			opts.desc = "Format document"
			keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)

            opts.desc = "Show code actions"
            keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

            opts.desc = "Move to previous diagnostic"
            keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

            opts.desc = "Move to next diagnostic"
            keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

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
                "texlab",
			},
			handlers = {
                function(server_name)
                    require('lspconfig')[server_name].setup({})
                end,


				lua_ls = function()
					local lua_opts = lsp.nvim_lua_ls()
					require("lspconfig").lua_ls.setup(lua_opts)
				end,

                gopls = function()
                    require('lspconfig').gopls.setup({
                        cmd = {"gopls"},
                        filetypes = { "go", "gomod", "gowork", "gotmpl" },
                        root_dir = util.root_pattern("go.work", "go.mod", ".git"),
                        settings = {
                            gopls = {
                                completeUnimported = true,
                                usePlaceholders = true,
                                analyses = {
                                    unusedparams = true
                                }
                            }
                        }
                    })
                end,
			},
		})
	end,
}
