local opt = {
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  relativenumber = true,
  number = true,
  ignorecase = true,
  smartcase = true,
  splitbelow = true,
  splitright = true,
  undofile = true,
  clipboard = 'unnamedplus',
  cursorline = true,
  signcolumn = 'yes',
  mouse = 'a',
  colorcolumn = '80,120',
  termguicolors = true,
  scrolloff = 5,
  sidescrolloff = 5,
  keywordprg = ':help'
}

for k, v in pairs(opt) do
  vim.opt[k] = v
end
