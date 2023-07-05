return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require('toggleterm').setup({
      open_mapping = require('mappings').toggleterm(),
      direction = 'float'
    })
  end
}
