{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    # Enhanced plugin selection for VS Code-like experience
    plugins = with pkgs.vimPlugins; [
      # Core plugins
      vim-sensible
      vim-commentary
      vim-surround
      vim-lastplace
      vim-sleuth
      direnv-vim

      # VS Code-like UI
      telescope-nvim
      telescope-fzf-native-nvim
      nvim-web-devicons
      lualine-nvim
      bufferline-nvim
      nvim-tree-lua

      # Development features
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      gitsigns-nvim
      which-key-nvim
      indent-blankline-nvim
      toggleterm-nvim

      # Completion
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip

      # Theme
      tokyonight-nvim
      mini-icons
    ];

    # Custom Lua configuration
    extraLuaConfig = builtins.readFile ./neovim.lua;
  };
}
