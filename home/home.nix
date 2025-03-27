{ pkgs
, username
, ...
}:
{
  imports = [
    ./modules
  ];

  modules.firefox.enable = true;

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "24.11";

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
      home-manager
      # Utilities
      fastfetch
      glances
      tmux
      xclip
      curl
      wget
      tree
      asar
      fuse
      dos2unix
      zoxide
      appimage-run
      wine # Windows
      ventoy
      shc # Shell compiler
      nh # Nix Garbage Cleaner

      # Editors & Viewers
      eza # ls
      bat # cat
      fd # find
      ripgrep # Better than grep
      dust # Disk usage visualization

      # Git Tools
      git
      gh # GitHub CLI
      gitui # Terminal UI for git

      # Nix Tools
      nix-prefetch-github

      # Language Servers
      lua-language-server
      nil

      # System Monitoring
      inxi
      procs

      # Diffing
      diff-so-fancy

      # Extractors
      unzip
      unrar
      p7zip
      xz
      zstd
      cabextract
    ];
  };
}
