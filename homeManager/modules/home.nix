{
  self,
  userConfig,
  lib,
  pkgs,
  ...
}:
let
  editor = "nvim";
  browser = "firefox";
  terminal = "ghostty";
  pager = "less";
  manpager = "less -R";
  flakePath = "${self}";
in
{
  imports = [
    ./cli
    ./programs
    ./services
    ./system
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # lorri is a Nix development environment manager
  services.lorri.enable = true;

  home = {
    inherit (userConfig) username;
    homeDirectory = "/home/${userConfig.username}";
    stateVersion = lib.trivial.release;
    shell.enableZshIntegration = true;

    sessionVariables = {
      EDITOR = editor;
      GIT_EDITOR = editor;
      VISUAL = editor;
      BROWSER = browser;
      TERMINAL = terminal;
      SYSTEMD_PAGERSECURE = "true";
      PAGER = pager;
      MANPAGER = manpager;
      FLAKE = flakePath;
      NH_FLAKE = flakePath;
      DO_NOT_TRACK = 1;
    };

    packages = with pkgs; [
      # Secrets management tool
      sops

      # Terminal Utilities
      rlwrap # Readline wrapper for cli programs
      libgcc
      armadillo # C++ linear algebra library
      blitz # Array library for C++
      appvm # Nix based app-vm
      neovim # EDITOR
      mpi
      tmux
      fastfetch
      xclip
      curl
      wget
      tree
      stow
      zellij
      bat
      file
      icdiff
      tea
      less
      procs
      lsd
      fd
      ripgrep
      zoxide
      glances
      fzf
      jj # JSON Stream Editor
      cheat # CheatSheet
      bottom
      just
      tree-sitter # Parser generator tool
      gdu # Disk usage analyzer CLI
      seahorse # managing encryption keys

      # Language Servers
      lua-language-server
      nil
      just-lsp

      # Extractors
      unzip
      unrar
      p7zip
      xz
      zstd
      cabextract

      # git
      git
      git-lfs
      delta
      mergiraf
    ];
  };
}
