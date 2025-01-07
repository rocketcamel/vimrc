return {
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
			vim.keymap.set("n", "<C-p>", builtin.git_files, {})
			vim.keymap.set("n", "<leader>ps", function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end)
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			transparent = true,
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
				"javascript",
				"typescript",
				"rust",
			},
			sync_install = true,
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/nvim-cmp",
			"j-hui/fidget.nvim",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip"
		},
		config = function()
			require("fidget").setup({})
			require("mason").setup()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"ts_ls",
					"lua_ls",
					"rust_analyzer",
				},
				handlers = {
					function(server)
						require("lspconfig")[server].setup({ capabilities = capabilities })
					end,
				},
			})

			local cmp = require("cmp")

			cmp.setup({
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
					end,
				},

				mapping = cmp.mapping.preset.insert({
					-- Simple tab complete
					['<Tab>'] = cmp.mapping(function(fallback)
						local col = vim.fn.col('.') - 1

						if cmp.visible() then
							cmp.select_next_item({ behavior = 'select' })
						elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
							fallback()
						else
							cmp.complete()
						end
					end, { 'i', 's' }),

					-- Go to previous item
					['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
				}),

				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				rust = { "rustfmt", lsp_format = "fallback" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				json = { "prettier" },
			},
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		},
	},
}
