# nvimconfig

## Ideas
- cherry pick from friendly-snippets/other sources 
- dictionary/spellcheck completion for text files
- nvim-cmp formatting/format
    - completion icons instead of text nvim-cmp/wiki/Menu-Appearance
    - completion source?

## Optimization possibilities
- lazy.nvim
    - `lazy = true` on big plugins
- Telescope
    ```lua
    -- Dependencies: make, GCC/Clang
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make'
    }
    ```

## System Packages
`brew install ripgrep fd make git curl`
`npm install -g tree-sitter-cli`
`command xcode-select --install`
- eslint
    - `npm install -g eslint` or a locally installed version is needed in the working directory
- Treesitter
    - `npm install tree-sitter-cli`
    - needed for `auto_install = true`
- Telescope
    - ripgrep
        - Linux: `sudo apt install ripgrep` 
        - macOS: `brew install ripgrep`
    - fd
        - Linux `sudo apt install fd-find`
        - macOS: `brew install fd`
    - telescope-fzf-native.nvim
        - make, GCC/Clang
- Mason
    - git
    - curl
- Gitsigns
    - git

## Known issues
- Mason build `:MasonUpdate` throws error on first run of the config
