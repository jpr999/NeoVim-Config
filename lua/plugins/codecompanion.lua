return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim", -- v0.1.0 or later is recommended
			"nvim-treesitter/nvim-treesitter", -- ensure the correct version for compatibility
			"hrsh7th/nvim-cmp",
			"nvim-telescope/telescope.nvim",
			{ "stevearc/dressing.nvim", opts = {} },
		},
		config = function(_, opts)
			require("codecompanion").setup({
				strategies = {
					chat = {
						adapter = "ollama",
						model = "gpt-oss:20b",
						tools = {
							["mcp"] = {
								callback = function()
									return require("mcphub.extensions.codecompanion")
								end,
								opts = {
									requires_approval = true, -- Safety toggle
									temperature = 0.7, --# Control creativity
								},
							},
						},
					},
					actions = {
						adapter = "ollama",
						model = "gpt-oss:20b",
						--model = "qwen3:14b",
					},
					inline = {
						adapter = "ollama",
						model = "gpt-oss:20b",
						--model = "qwen3:14b",
					},
				},
			})

			vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>CodeCompanionActions<cr>", {
				noremap = true,
				silent = true,
				desc = "Show CodeCompanion [A]ctions",
			})

			vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", {
				noremap = true,
				silent = true,
				desc = "CodeCompanion Toggle",
			})

			vim.keymap.set({ "n", "v" }, "<leader>ci", "<cmd>CodeCompanion<cr>", {
				noremap = true,
				silent = true,
				desc = "Inline CodeCompanion",
			})

			local progress = require("fidget.progress")
			local handles = {}
			local group = vim.api.nvim_create_augroup("CodeCompanionFidget", {})

			vim.api.nvim_create_autocmd("User", {
				pattern = "CodeCompanionRequestStarted",
				group = group,
				callback = function(e)
					handles[e.data.id] = progress.handle.create({
						title = "CodeCompanion",
						message = "Thinking...",
						lsp_client = { name = e.data.adapter.formatted_name },
					})
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "CodeCompanionRequestFinished",
				group = group,
				callback = function(e)
					local h = handles[e.data.id]
					if h then
						h.message = e.data.status == "success" and "Done" or "Failed"
						h:finish()
						handles[e.data.id] = nil
					end
				end,
			})
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "codecompanion" },
	},

	{
		"echasnovski/mini.diff",
		config = function()
			local diff = require("mini.diff")
			diff.setup({
				-- Disabled by default
				source = diff.gen_source.none(),
			})
		end,
	},
}
