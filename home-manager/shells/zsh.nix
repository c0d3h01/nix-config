{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkOrder;
in
{
  programs.zsh = {
    enable = true;

    autocd = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    # History configuration
    history = {
      size = 5000;
      save = 5000;
      path = "${config.home.homeDirectory}/.config/zsh/.zsh_history";
      ignoreSpace = true;
      ignoreDups = true;
      expireDuplicatesFirst = true;
      share = true;
    };

    # Environment variables
    sessionVariables = {
      DISABLE_AUTO_TITLE = "true";
      COMPLETION_WAITING_DOTS = "false";
      HIST_STAMPS = "dd.mm.yyyy";
      LC_ALL = "en_US.UTF-8";
      LANG = "en_US.UTF-8";
      TERM = "xterm-256color";
    };

    # Completion styling
    completionInit = ''
      autoload -Uz compinit
      zmodload zsh/complist
      compinit -d

      zstyle ':completion:*' menu select
      zstyle ':completion:*' group-name '''
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' list-colors "''${LS_COLORS}"
      zstyle ':completion:::::' completer _expand _complete _ignored _approximate

      # FZF-tab config
      zstyle ':completion:*:git-checkout:*' sort false
      zstyle ':fzf-tab:*' use-fzf-default-opts yes
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -1 --color=always $realpath'
    '';

    # Plugins
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
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.8.0";
          sha256 = "sha256-iJdWopZwHpSyYl5/FQXEW7gl/SrKaYDEtTH9cGP7iPo=";
        };
      }
      {
        name = "zsh-completions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-completions";
          rev = "0.35.0";
          sha256 = "sha256-GFHlZjIHUWwyeVoCpszgn4AmLPSSE8UVNfRmisnhkpg=";
        };
      }
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "v1.1.2";
          sha256 = "sha256-Qv8zAiMtrr67CbLRrFjGaPzFZcOiMVEFLg1Z+N6VMhg=";
        };
      }
    ];

    # Autosuggestions config
    initContent = mkOrder 1000 ''
      # Autosuggestions
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"
      ZSH_AUTOSUGGEST_STRATEGY=(history completion)
      ZSH_AUTOSUGGEST_USE_ASYNC="true"

      # Vim mode
      autoload -Uz edit-command-line
      zle -N edit-command-line
      bindkey -v
      bindkey '^P' history-search-backward
      bindkey '^N' history-search-forward
      bindkey '^?' backward-delete-char
      bindkey '^h' backward-delete-char
      bindkey '^w' backward-kill-word
      bindkey '^H' backward-kill-word
      bindkey '^[^?' backward-kill-word
      bindkey '^a' beginning-of-line
      bindkey '^e' end-of-line
      bindkey '^xe' edit-command-line
      bindkey '^x^e' edit-command-line
      bindkey "''${terminfo[kcuu1]}" history-search-backward
      bindkey "''${terminfo[kcud1]}" history-search-forward
      export KEYTIMEOUT=1

      # Prevent broken terminals
      ttyctl -f

      # Source credentials if exists
      [[ -f "$HOME/.credentials" ]] && source "$HOME/.credentials"
      [[ -f "$ZDOTDIR/.zsh_dir_hashes" ]] && source "$ZDOTDIR/.zsh_dir_hashes"

      # Set options
      setopt auto_list
      setopt auto_menu
      setopt always_to_end
      setopt interactive_comments
      setopt HIST_FIND_NO_DUPS
      setopt HIST_SAVE_NO_DUPS

      function title_precmd_hook() {
        print -Pn "\e]0;$(pwd)\a"
      }
      precmd_functions+=title_precmd_hook
    '';
  };
}
