{
  pkgs,
  userConfig,
  outputs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    ./configs
    ./modules
  ];

  home = {
    username = "${userConfig.username}";
    homeDirectory = "/home/${userConfig.username}";
    stateVersion = "${userConfig.stateVersion}";

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      TERMINAL = "kitty";
      BROWSER = "firefox";
      PAGER = "less";
      LESS = "-R";
    };

    sessionPath = [
      "$HOME/.npm-global/bin"
    ];

    packages = with pkgs; [
      # Terminal
      kitty

      # Utilities
      coreutils
      bashInteractive
      fastfetch
      glances
      xclip
      curl
      wget
      tree
      asar
      fuse
      appimage-run
      nh # Nix Garbage Cleaner

      # Editors & Viewers
      fd # find
      file

      # Nix Tools
      nix-prefetch-github

      # Language Servers
      lua-language-server
      nil

      # System Monitoring
      inxi
      procs

      # Extractors
      unzip
      unrar
      p7zip
      xz
      zstd
      cabextract
    ];
  };

  programs = {
    ssh = {
      enable = true;
      matchBlocks = {
        "c0d3h01" = {
          hostname = "c0d3h01";
          user = "root";
          forwardAgent = true;
        };
      };
    };
  };
}
