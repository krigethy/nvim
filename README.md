# nvimconfig

## Ideas

- add "install with" command to README
- cherry pick from friendly-snippets/other sources
- dictionary/spellcheck completion for text files
- nvim-cmp formatting/format
  - completion icons instead of text nvim-cmp/wiki/Menu-Appearance
  - completion source?

## Optimization possibilities

- lazy.nvim
  - `lazy = true` on big plugins
- Telescope
  ```luak
  -- Dependencies: make, GCC/Clang
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make'
  }
  ```

## System Packages

`brew install ripgrep fd make git curl lazygit`
`npm install -g tree-sitter-cli`
`command xcode-select --install`

- eslint
  - `npm install -g eslint` or a locally installed version is needed in the working directory
- Treesitter
  - `npm install -g tree-sitter-cli`
  - needed for `auto_install = true`
- Telescope
  - `brew install ripgrep fd`
  - telescope-fzf-native.nvim
    - make, GCC/Clang
- Mason
  - git
  - curl
- Gitsigns
  - git
