return {
	"EdenEast/nightfox.nvim",
	name = "nightfox",
	priority = 1000,
	opts = {},
	config = function()
		require("nightfox").setup({
			options = {
				dim_inctive = true,
				transparent = true,
			},
		})

		require("nightfox").setup()

		vim.cmd("colorscheme carbonfox")

		require("lualine").setup({
			options = {
				-- ... other configuration
				theme = "auto", -- Can also be "auto" to detect automatically.
			},
		})
	end,
}
