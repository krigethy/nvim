return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('nvim-tree').setup({
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = false
      },
      disable_netrw = true,
      filters = { dotfiles = true },
      git = { show_on_open_dirs = false },
      hijack_cursor = true,
      modified = {
        enable = true,
        show_on_open_dirs = false
      },
      on_attach = require('mappings').nvimtree(),
      renderer = {
        full_name = true,
        group_empty = true,
        indent_markers = { enable = true },
        -- Use `:t` to show parent folder
        root_folder_label = false
      }
    })
  end
}
