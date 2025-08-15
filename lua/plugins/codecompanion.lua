return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",        -- v0.1.0 or later is recommended
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
            model = "gpt-oss",
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
            model = "gpt-oss",
          },
          inline = {
            adapter = "ollama",
            model = "gpt-oss",
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

  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
    },
    -- uncomment the following line to load hub lazily
    --cmd = "MCPHub",  -- lazy load
    build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
    --uncomment this if you don't want mcp-hub to be available globally or can't use -g
    --build = "bundled_build.lua", -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
    config = function()
      require("mcphub").setup({
        -- Required options
        port = 3000,                                                -- Port for MCP Hub server
        config = vim.fn.expand("~/.config/lvim/lvim-mcp-servers.json"), -- Absolute path to config file
      })
    end,
  },
}
