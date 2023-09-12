local M = {}
local map = vim.keymap.set

-- Leader
map('', '<Leader>', '<Nop>')
vim.g.mapleader = ' '

-- Clear search highlights
map('n', '<Leader>/', '<Cmd>nohlsearch<CR>')

-- Window navigation
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

map('n', '<Bslash>m', '<Cmd>Mason<CR>')
map('n', '<Bslash>l', '<Cmd>Lazy<CR>')
map('n', '<Bslash>g', '<Cmd>LazyGit<CR>')

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
-- Additional diagnostic/lsp mappings at `M.telescope`
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    map('n', '<Leader>i', vim.diagnostic.open_float)
    map('n', '[d', vim.diagnostic.goto_prev)
    map('n', ']d', vim.diagnostic.goto_next)
    map('n', 'K', vim.lsp.buf.hover, opts)
    map('n', '<Leader>r', vim.lsp.buf.rename, opts)
    map('n', '<Leader>a', vim.lsp.buf.code_action, opts)
    map('n', '<Leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
    -- TODO I don't know about this, maybe if it was an auto popup in insert
    map('n', '<Leader>s', vim.lsp.buf.signature_help, opts)
    -- TODO Do I need these?
    -- map('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    -- map('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    -- map('n', '<Leader>wl', function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts)
  end,
})

M.nvimtree = function()
  map('n', '<Leader>e', '<Cmd>NvimTreeFocus<CR>')
  map('n', '<C-n>', '<Cmd>NvimTreeToggle<CR>')

  return function(bufnr)
    local api = require('nvim-tree.api')
    local function opts(desc)
      return {
        desc = 'nvim-tree: ' .. desc,
        buffer = bufnr,
        noremap = true,
        silent = true,
        nowait = true
      }
    end
    -- Default mappings
    api.config.mappings.default_on_attach(bufnr)
    -- Custom mappings
    map('n', '?', api.tree.toggle_help, opts('Help'))
    map('n', 'd', api.fs.trash, opts('Trash'))
    map('n', 'D', api.fs.remove, opts('Delete'))
    map('n', ']d', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
    map('n', '[d', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
    map('n', '<C-s>', api.node.open.horizontal, opts('Open: Horizontal Split'))
    map('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
  end
end

M.telescope = function()
  local builtin = require('telescope.builtin')
  map('n', '<leader>o', builtin.find_files)
  map('n', '<leader>g', builtin.live_grep)
  map('n', '<leader>h', builtin.help_tags)
  map('n', '<leader>8', builtin.grep_string)
  map('n', 'gr', builtin.lsp_references)
  map('n', 'gd', builtin.lsp_definitions)
  map('n', '<leader>q', builtin.diagnostics)
  -- TODO do I need these?
  -- map('n', '<leader>', builtin.oldfiles)
  -- map('n', '<leader>', builtin.registers)
  -- map('n', '<leader>', builtin.spell_suggest)
  -- map('n', '<leader>', builtin.current_buffer_fuzzy_find)

  local actions = require('telescope.actions')
  return {
    i = {
      ['<Esc>'] = actions.close,
      ['<C-s>'] = actions.select_horizontal,
      ['<C-v>'] = actions.select_vertical
    }
  }
end

M.cmp = function()
  local cmp = require('cmp')
  local luasnip = require('luasnip')
  return {
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.abort(),
    -- TODO this is for <C-CR>, I need a better solution here
    -- Have to look into alacritty/tmux config as well
    ['\n'] = cmp.mapping({
      i = function(_)
        if cmp.visible() then
          cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert })
        else
          cmp.complete()
        end
      end
    }),
    ['<CR>'] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() and cmp.get_active_entry() then
          cmp.confirm({ select = false, behavior = cmp.ConfirmBehavior.Insert })
        else
          fallback()
        end
      end
    }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { 'i', 's' }
    ),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }
    )
  }
end

M.gitsigns = function(bufnr)
  local gs = package.loaded.gitsigns
  local opts = { buffer = bufnr }

  map('n', ']c', function()
    if vim.wo.diff then return ']c' end
    vim.schedule(function() gs.next_hunk({ preview = true }) end)
    return '<Ignore>'
  end, { buffer = bufnr, expr = true })

  map('n', '[c', function()
    if vim.wo.diff then return '[c' end
    vim.schedule(function() gs.prev_hunk({ preview = true }) end)
    return '<Ignore>'
  end, { buffer = bufnr, expr = true })

  map('n', '<Bslash>i', gs.preview_hunk, opts)
  map('n', '<Bslash>b', function() gs.blame_line { full = true } end, opts)
  map('n', '<Bslash>s', gs.stage_hunk, opts)
  map('v', '<Bslash>s', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, opts)
  map('n', '<Bslash>S', gs.stage_buffer, opts)
  map('n', '<Bslash>u', gs.undo_stage_hunk, opts)
  map('n', '<Bslash>r', gs.reset_hunk, opts)
  map('v', '<Bslash>r', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, opts)
  map('n', '<Bslash>R', gs.reset_buffer, opts)

  -- Text object
  map({ 'o', 'x' }, 'ih', '<Cmd>Gitsigns select_hunk<CR>', opts)
end

return M
