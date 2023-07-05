require('autocommands')
require('mappings')
require('options')

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins and configure lazy.nvim
require('lazy').setup(
  'plugins',
  {
    colorscheme = { 'tokyonight', 'habamax'},
    change_detection = { notify = false },
    lockfile = vim.fn.stdpath('config') .. '/lua/plugins/lazy-lock.json'
  }
)
