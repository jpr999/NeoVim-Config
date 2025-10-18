return {
	"mason-org/mason-lspconfig.nvim",
	opts = {
		ensure_installed = { "lua_ls", "eslint", "postgres_lsp", "tailwindcss", "ts_ls" },
		automatic_enable = true,
	},

	dependencies = {
		{
			"mason-org/mason.nvim",
			opts = {
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			},
		},
		{
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",

			dependencies = {
				"j-hui/fidget.nvim",
				config = function()
					require("plugins.fidget")
				end,
			},
		},
		{ "hrsh7th/nvim-cmp", dependencies = { "L3MON4D3/LuaSnip" } },
		{
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			opts = {
				ensure_installed = { "prettier", "prettierd", "shellcheck" },
				auto_update = true,
			},
		},
	},
}
