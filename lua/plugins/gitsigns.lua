return {
  'lewis6991/gitsigns.nvim',
  config = function ()
    require('gitsigns').setup({
      on_attach = require('mappings').gitsigns
    })
  end
}
