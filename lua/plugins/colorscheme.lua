-- return {
--   'folke/tokyonight.nvim',
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require('tokyonight').setup({
--       -- Possibilities: day, moon, night, storm
--       style = 'night',
--       dim_inactive = true
--     })
--     vim.cmd.colorscheme('tokyonight')
--   end
-- }

return {
  'rose-pine/neovim',
  name = 'rose-pine',
  lazy = false,
  priority = 1000,
  config = function()
    require('rose-pine').setup({})
    vim.cmd.colorscheme('rose-pine')
  end
}
