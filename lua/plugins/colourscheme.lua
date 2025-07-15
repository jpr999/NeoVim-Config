return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      local bg = "#020201"

      require("tokyonight").setup({
        style = "moon",
        transparency = 0.9,
        on_colors = function(colors)
          colors.bg = bg
        end,
      })
      vim.cmd [[colorscheme tokyonight]]
    end
  }
}
