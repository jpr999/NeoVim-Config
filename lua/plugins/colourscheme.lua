return {
  {
    --    "catppuccin/nvim",
    --    name = "catppuccin",
    --    priority = 1000,
    --    opts = {},
    --    config = function()
    --      vim.cmd [[colorscheme catppuccin-mocha]]
    --    end
    "wnkz/monoglow.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd [[colo monoglow-z]]
    end
  }
}
