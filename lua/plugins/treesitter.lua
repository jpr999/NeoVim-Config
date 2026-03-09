return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPost', 'BufNewFile' },
  build = ':TSUpdate',
  opts = {
    ensure_installed = {
      'bash',
      'css',
      'gitignore',
      'html',
      'javascript',
      'json',
      'lua',
      'markdown',
      'markdown_inline',
      'python',
      'query',
      'regex',
      'sql',
      'toml',
      'typescript',
      'tsx',
      'vim',
      'vimdoc',
      'yaml',
      -- "mermaid", -- requires markdown-preview.nvim
      -- 'latex', -- requires tree-sitter-cli
    },
    highlight = { enable = true },
    indent = { enable = true, disable = { 'ruby', 'markdown' } },
    auto_install = true,
  },
}
