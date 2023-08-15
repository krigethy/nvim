return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
  build = function()
    require('nvim-treesitter.install').update({ with_sync = true })
  end,
  config = function()
    require('nvim-treesitter.configs').setup({
      auto_install = true,
      context_commentstring = {
        enable = true,
        enable_autocmd = false
      },
      -- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
      ensure_installed = {
        'bash',
        'comment',
        'css',
        'dockerfile',
        'html',
        'javascript',
        'json',
        'lua',
        'markdown',
        'python',
        'scss',
        'toml',
        'typescript',
        'vimdoc',
        'yaml'
      },
      highlight = { enable = true },
      ignore_install = {},
      indent = { enable = true },
      modules = {},
      sync_install = false
    })
    -- Folding
    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    vim.opt.foldenable = false
  end
}
