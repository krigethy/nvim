return {
  'neovim/nvim-lspconfig',
  dependencies = {
    {
      'williamboman/mason.nvim'
    },
    'williamboman/mason-lspconfig.nvim',
    {
      'jose-elias-alvarez/null-ls.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'jay-babu/mason-null-ls.nvim'
      }
    },
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'b0o/SchemaStore.nvim'
  },
  config = function()
    -- Order is important: mason -> mason-lspconfig -> nvim-lspconfig
    require('mason').setup()
    require('mason-lspconfig').setup({
      ensure_installed = {
        'lua_ls',
        'eslint',
        'cssls',
        'html',
        'jsonls',
        'yamlls',
        'ansiblels',
        'tsserver'
      }
    })
    require('mason-null-ls').setup({
      automatic_installation = false,
      ensure_installed = { 'prettier', 'ansible-lint' }
    })

    local sign_define = vim.fn.sign_define
    sign_define('DiagnosticSignError', { texthl = 'DiagnosticSignError', text = '' })
    sign_define('DiagnosticSignWarn', { texthl = 'DiagnosticSignWarn', text = '' })
    sign_define('DiagnosticSignInfo', { texthl = 'DiagnosticSignInfo', text = '' })
    sign_define('DiagnosticSignHint', { texthl = 'DiagnosticSignHint', text = '' })

    vim.diagnostic.config({
      virtual_text = false,
      update_in_insert = true,
      severity_sort = true,
      float = {
        border = 'rounded',
        source = 'if_many',
        header = '',
        prefix = ''
      }
    })

    -- `capabilities` should be set in ALL language specific setups
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    local lspconfig = require('lspconfig')

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
            keywordSnippet = 'Replace'
          },
          diagnostics = { globals = { 'vim' } },
          telemetry = { enable = false },
          workspace = {
            checkThirdParty = false,
            library = vim.api.nvim_get_runtime_file('', true)
          }
        }
      }
    })

    lspconfig.eslint.setup({
      capabilities = capabilities
    })
    lspconfig.tsserver.setup({
      capabilities = capabilities
    })
    lspconfig.cssls.setup({
      capabilities = capabilities
    })
    lspconfig.html.setup({
      capabilities = capabilities
    })
    lspconfig.jsonls.setup({
      capabilities = capabilities,
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true }
        }
      }
    })
    lspconfig.yamlls.setup({
      capabilities = capabilities,
      settings = {
        yaml = {
          schemaStore = {
            -- You must disable built-in schemaStore support if you want to use
            -- this plugin and its advanced options like `ignore`.
            enable = false,
          },
          schemas = require('schemastore').yaml.schemas(),
        }
      }
    })

    -- Needs ansible-lint for linting, turned on by default
    lspconfig.ansiblels.setup({
      capabilities = capabilities
    })
    vim.filetype.add({
      -- These are Lua patterns, not regexes
      -- https://www.lua.org/manual/5.1/manual.html#5.4.1
      pattern = {
        -- y(a)ml files in handlers/roles/tasks folders
        ['.*/handlers/.*.ya?ml'] = 'yaml.ansible',
        ['.*/roles/.*.ya?ml'] = 'yaml.ansible',
        ['.*/tasks/.*.ya?ml'] = 'yaml.ansible',
        -- Files in group_vars/host_vars folders
        ['.*/group_vars/.*'] = 'yaml.ansible',
        ['.*/host_vars/.*'] = 'yaml.ansible',
        -- playbook/site/main.y(a)ml files
        ['main.ya?ml'] = 'yaml.ansible',
        ['playbook.ya?ml'] = 'yaml.ansible',
        ['site.ya?ml'] = 'yaml.ansible',
      }
    })

    local null_ls = require('null-ls')
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettier
      }
    })
  end
}
