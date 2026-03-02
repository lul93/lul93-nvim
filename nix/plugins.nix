{pkgs}:
with pkgs.vimPlugins; [
  # core
  lz-n
  lzn-auto-require
  rtp-nvim
  plenary-nvim
  neodev-nvim
  vim-startuptime

  # colorscheme
  catppuccin-nvim
  doom-one-nvim

  # ui
  lualine-nvim
  nvim-web-devicons
  # modicator-nvim
  twilight-nvim
  zen-mode-nvim
  dashboard-nvim

  # editing
  which-key-nvim
  comment-nvim
  nvim-surround
  nvim-autopairs
  tabout-nvim
  smart-splits-nvim
  flash-nvim
  hop-nvim
  fzf-lua

  # workspace
  project-nvim
  persistence-nvim
  vim-suda
  trouble-nvim

  # files buffers terminal vcs
  nvim-tree-lua
  barbar-nvim
  toggleterm-nvim
  gitsigns-nvim

  # lsp formatting
  nvim-lspconfig
  conform-nvim
  clangd_extensions-nvim

  # completion snippets
  nvim-cmp
  cmp-nvim-lsp
  cmp-nvim-lsp-signature-help
  cmp-nvim-lua
  cmp-buffer
  cmp-path
  cmp-cmdline
  luasnip
  friendly-snippets

  # treesitter
  nvim-treesitter
  nvim-treesitter.withAllGrammars
  nvim-treesitter-textobjects
  nvim-treesitter-parsers.meson
  treesitter-modules-nvim

  # telescope
  telescope-nvim
  telescope-ui-select-nvim
  telescope-file-browser-nvim
]
