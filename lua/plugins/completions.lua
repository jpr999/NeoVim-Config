return {
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },

		version = "1.*",
		opts = {
			sources = {
				default = { "codecompanion", "lsp", "path", "snippets", "buffer" },
				providers = {
					codecompanion = {
						name = "CodeCompanion",
						module = "codecompanion.providers.completion.blink",
						enabled = true,
					},
				},
			},
			keymap = {
				preset = "default",
				["<CR>"] = { "accept", "fallback" },
				["<C><leader>"] = { "show" },
			},
			appearance = {
				nerd_font_variant = "mono",
			},

			completion = { documentation = { auto_show = true } },
			--sources = {
			--local	default = { "lsp", "path", "snippets", "buffer" },
			--},

			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
}
