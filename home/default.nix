{ config
, pkgs
, specialArgs
, ...
}:
{
  imports = [
    ./modules
  ];

  modules.firefox.enable = true;

  home = {
    username = "${specialArgs.username}";
    homeDirectory = "/home/${specialArgs.username}";
    stateVersion = "24.11";

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      TERMINAL = "kitty";
      BROWSER = "firefox";
      PAGER = "less";
      LESS = "-R";
      # ANDROID_HOME = "/home/c0d3h01/Android";
      # ANDROID_SDK_ROOT = "/home/c0d3h01/Android";
      # ANDROID_NDK_HOME = "/home/c0d3h01/Android/android-ndk-r27c";
      # PATH = "$HOME/Android/cmdline-tools/bin:$HOME/Android/platform-tools:$HOME/Android/android-ndk-r27c:$PATH";
      CHROME_EXECUTABLE = "${pkgs.chromium}/bin/chromium";
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
