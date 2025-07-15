return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'hrsh7th/nvim-cmp',
      'nvim-telescope/telescope.nvim',
      { 'stevearc/dressing.nvim', opts = {} },
    },
    config = function(_, opts)
      require('codecompanion').setup {
        strategies = {
          chat = { adapter = 'ollama', model = 'qwen2.5-coder:latest' },
          actions = { adapter = 'ollama', model = 'qwen2.5-coder:latest' },
          inline = { adapter = 'ollama', model = 'qwen2.5-coder:latest' },
        },
      }

      vim.keymap.set({ 'n', 'v' }, '<leader>a', '<cmd>CodeCompanionActions<cr>', {
        noremap = true,
        silent = true,
        desc = 'Show CodeCompanion [A]ctions',
      })

      vim.keymap.set({ 'n', 'v' }, '<leader>`', '<cmd>CodeCompanionChat Toggle<cr>', {
        noremap = true,
        silent = true,
        desc = 'CodeCompanion Toggle',
      })

      require("codecompanion").setup(opts)

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



      vim.cmd [[cab cc CodeCompanion]]
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
  },
}
