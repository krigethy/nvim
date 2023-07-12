-- System dependencies: ripgrep, fd
return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    -- TODO add LSP dependency
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('telescope').setup({
      defaults = {
        mappings = require('mappings').telescope(),
        layout_config = { horizontal = { prompt_position = 'top' } },
        sorting_strategy = 'ascending'
      }
    })
  end
}
