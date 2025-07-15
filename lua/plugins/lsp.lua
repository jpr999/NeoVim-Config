return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        },

        --ts_ls = {
        --  on_attach = function(client, bufnr)
        --    require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
        --  end,
        --},
        ts_ls = {},
        eslint = {},
        tailwindcss = {},
      },
    },
    config = function(_, opts)
      require("mason").setup()

      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "lua_ls", "eslint", "tailwindcss", "ts_ls" }
      })

      for server, config in pairs(opts.servers) do
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end
    end
  },
}
