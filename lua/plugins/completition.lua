return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      version = '1.*',
      build = 'make install_jsregexp'
    },
    -- Completition sources
    'hrsh7th/cmp-nvim-lsp',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline'
  },
  config = function()
    local cmp = require('cmp')
    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
      },
      mapping = cmp.mapping.preset.insert(
        require('mappings').cmp()
      ),
      -- TODO formatting
      -- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'nvim_lsp_signature_help' },
        {
          name = 'path',
          option = { label_trailing_slash = true }
        },
        { name = 'buffer' }
      }
    })

    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      formatting = {
        fields = { 'abbr' }
      },
      sources = {
        { name = 'buffer' }
      }
    })
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      formatting = {
        fields = { 'abbr' }
      },
      sources = {
        { name = 'path' },
        { name = 'cmdline' }
      }
    })

    -- Lazy load snippet
    require('luasnip.loaders.from_vscode').lazy_load({ paths = 'snippets/' })
  end
}
