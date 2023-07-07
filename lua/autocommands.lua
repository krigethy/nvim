local autocmd = vim.api.nvim_create_autocmd

-- Highlight yanked text
autocmd(
  'TextYankPost', {
    pattern = '*',
    callback = function()
      vim.highlight.on_yank({ timeout = 500 })
    end
  }
)

-- Bigger tab for Python files
autocmd(
  'FileType', {
    pattern = 'python',
    command = 'setlocal ts=4 sts=4 sw=4 expandtab'
  }
)

-- Turn on spell checking for text files
autocmd(
  'FileType', {
    pattern = { 'markdown', 'text', 'gitcommit' },
    command = 'setlocal spell'
  }
)

-- Automatically even out window sizes on resizing Vim
autocmd(
  'VimResized', {
    command = 'wincmd ='
  }
)
