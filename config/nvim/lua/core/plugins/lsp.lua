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
		"ray-x/lsp_signature.nvim",
	},
	config = function()
		local lsp = require("lsp-zero")
		lsp.preset("recommended")

		local util = require("lspconfig/util")

		lsp.setup_servers({})

		local cmp = require("cmp")
		local cmp_action = require("lsp-zero").cmp_action()
		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		require("lsp_signature").setup({
			hint_enable = false,
		})

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
				["<C-b>"] = cmp_action.luasnip_jump_forward(),
				["<C-f>"] = cmp_action.luasnip_jump_backward(),
			}),
		})

		lsp.set_sign_icons({
			error = " ",
			warn = " ",
			hint = "󰠠 ",
			info = " ",
		})

		lsp.on_attach(function(client, bufnr)
			local opts = { buffer = bufnr }
			local keymap = vim.keymap

			local ts = require("telescope.builtin")

            -- This is where the variable was first declared, or the function first defined
			opts.desc = "[G]oto [D]efinition"
			keymap.set("n", "gd", ts.lsp_definitions, opts)

            -- Definition of its type, not where it was defined
            opts.desc = "[G]oto [D]efinition"
            keymap.set("n", "<leader>D", ts.lsp_type_definitions, opts)

            -- References for the word under cursor
			opts.desc = "[G]oto [R]eferences"
			keymap.set("n", "gr", ts.lsp_references, opts)

            -- Implementations for word under cursor
			opts.desc = "[G]oto [I]mplementation"
			keymap.set("n", "gI", ts.lsp_implementations, opts)

            -- Declaration, this would take you to the header in C
			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

			opts.desc = "[D]ocument [S]ymbols"
			keymap.set("n", "<leader>ds", ts.lsp_document_symbols, opts)

			opts.desc = "[W]orkspace [S]ymbols"
			keymap.set("n", "<leader>ws", ts.lsp_dynamic_workspace_symbols, opts)

			opts.desc = "Show signiture information"
			keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)

			opts.desc = "Show diagnostics"
			keymap.set("n", "gl", vim.diagnostic.open_float, opts)

			opts.desc = "Hover Documentation"
			keymap.set("n", "K", vim.lsp.buf.hover, opts)

			opts.desc = "[R]e[N]ame"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

			opts.desc = "Format document"
			keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)

			opts.desc = "[C]ode [A]ction"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

			opts.desc = "Move to previous diagnostic"
			keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

			opts.desc = "Move to next diagnostic"
			keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
		end)

		require("mason").setup({})
		require("mason-lspconfig").setup({
			ensure_installed = {
				"ts_ls",
				"eslint",
				"html",
				"cssls",
				"lua_ls",
				"emmet_ls",
				"pyright",
				"clangd",
				"bashls",
				"cmake",
				"dockerls",
				"docker_compose_language_service",
				"jsonls",
				"rust_analyzer",
				"sqlls",
				"texlab",
                "ansiblels",
                "bicep"
			},
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,

				lua_ls = function()
					require("lspconfig").lua_ls.setup({
						settings = {
							Lua = {
								runtime = { version = "LuaJIT" },
								workspace = {
									checkThirdParty = false,
									library = {
										"${3rd}/luv/library",
										unpack(vim.api.nvim_get_runtime_file("", true)),
									},
								},
								completion = {
									callSnippet = "Replace",
								},
							},
						},
					})
				end,

				gopls = function()
					require("lspconfig").gopls.setup({
						cmd = { "gopls" },
						filetypes = { "go", "gomod", "gowork", "gotmpl" },
						root_dir = util.root_pattern("go.work", "go.mod", ".git"),
						settings = {
							gopls = {
								completeUnimported = true,
								usePlaceholders = true,
								analyses = {
									unusedparams = true,
								},
							},
						},
					})
				end,

				ts_ls = function()
					require("lspconfig").ts_ls.setup({
						init_options = {
							preferences = {
								disableSuggestions = true,
								importModuleSpecifierPreference = "relative",
								importModuleSpecifierEnding = "minimal",
							},
						},
					})
				end,

				clangd = function()
					require("lspconfig").clangd.setup({
						cmd = {
							"clangd",
							"--offset-encoding=utf-16",
							"--background-index",
							"--clang-tidy",
							"--log=verbose",
							"--compile-commands-dir=.",
							"--compile-commands-dir=build",
						},
						root_dir = util.root_pattern(
							".clang-format",
							"compile_commands.json",
							"compile_flags.json",
							".git"
						),
					})
				end,
			},
		})
	end,
}
