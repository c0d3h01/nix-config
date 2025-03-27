{ config
, pkgs
, ...
}:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    autocd = true;
    dotDir = ".config/zsh";

    history = {
      extended = true;
      ignoreDups = true;
      expireDuplicatesFirst = true;
      ignoreSpace = true;
      save = 15000;
      size = 15000;
      path = "${config.xdg.dataHome}/zsh/history";
      share = true;
    };

    shellAliases = {
      # Navigation
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      # Modern ls replacements
      ls = "eza --icons --group-directories-first";
      ll = "eza -l --icons --group-directories-first --git";
      la = "eza -a --icons --group-directories-first";
      lt = "eza --tree --icons --level=2";
      # Git shortcuts
      g = "git";
      ga = "git add";
      gs = "git status";
      gc = "git commit";
      gph = "git push";
      gpl = "git pull";
      # Safety nets
      rm = "rm -I";
      cp = "cp -i";
      mv = "mv -i";
      # Modern alternatives
      cat = "bat";
      grep = "rg";
      find = "fd";
      # Handy shortcuts
      ff = "fastfetch";
      cl = "clear";
      x = "exit";
      v = "nvim";
    };

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "z"
        "sudo"
        "colored-man-pages"
        "command-not-found"
        "fzf"
      ];
    };

    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
        };
      }
      {
        name = "fast-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zdharma-continuum";
          repo = "fast-syntax-highlighting";
          rev = "v1.55";
          sha256 = "0h7f27gz586xxw7cc0wyiv3bx0x3qih2wwh05ad85bh2h834ar8d";
        };
      }
    ];

    # Environment setup
    envExtra = ''
      export MANPAGER="nvim +Man!"
    '';

    # Functional config
    initExtra = ''
            # Improved Vi mode
            bindkey -v
            bindkey '^?' backward-delete-char
            bindkey '^h' backward-delete-char
            bindkey '^w' backward-kill-word
      
            # Directory stack
            setopt AUTO_PUSHD
            setopt PUSHD_IGNORE_DUPS
      
            # Extract function
            extract() {
          if [ -z "$1" ]; then
              echo "Usage: extract <file>"
              return 1
          fi

          if [ ! -f "$1" ]; then
              echo "Error: '$1' is not a valid file"
              return 1
          fi

          case "$1" in
              # Tar archives
              *.tar)       tar xf "$1"       ;;
              *.tar.bz2)   tar xjf "$1"      ;;
              *.tbz2)      tar xjf "$1"      ;;
              *.tar.gz)    tar xzf "$1"      ;;
              *.tgz)       tar xzf "$1"      ;;
              *.tar.xz)    tar xJf "$1"      ;;
              *.txz)       tar xJf "$1"      ;;
              *.tar.zst)   tar --use-compress-program=unzstd -xf "$1" ;;

              # Compressed files
              *.7z)        7z x "$1"         ;;
              *.zip)       unzip "$1"        ;;
              *.rar)       unrar x "$1"      ;;
              *.gz)        gunzip "$1"       ;;
              *.bz2)       bunzip2 "$1"      ;;
              *.xz)        unxz "$1"         ;;
              *.zst)       unzstd "$1"       ;;

              # Archives
              *.war)       unzip "$1"        ;;
              *.jar)       unzip "$1"        ;;
              *.deb)       ar x "$1"         ;;

              # Compressed images
              *.Z)         uncompress "$1"   ;;

              # Apple disk image
              *.dmg)       hdiutil mount "$1" ;;

              # Windows compressed files
              *.cab)       cabextract "$1"   ;;

              # If no matching type is found
              *)
                  echo "Error: Cannot extract '$1' - unknown file type"
                  return 1
                  ;;
          esac

          # Check if extraction was successful
          if [ $? -eq 0 ]; then
              echo "Successfully extracted: $1"
          else
              echo "Extraction failed for: $1"
              return 1
          fi
      }
    '';
  };

  # Starship prompt
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = "$directory$git_branch$git_status$cmd_duration$line_break$character";
      add_newline = false;

      directory = {
        style = "bold cyan";
        truncation_length = 3;
        format = "[$path]($style) ";
      };

      git_branch = {
        symbol = " ";
        style = "bold purple";
        format = "[$symbol$branch]($style) ";
      };

      git_status = {
        style = "bold yellow";
        format = "[$all_status$ahead_behind]($style) ";
      };

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
        vicmd_symbol = "[❮](bold blue)";
      };
    };
  };

  # Essential complementary tools
  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
