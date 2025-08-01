#! /bin/zsh

# Basic exports
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export TERM="ghostty"
export EDITOR='nvim'
export VISUAL="$EDITOR"
export SUDO_EDITOR="$EDITOR"
export BROWSER='firefox'
export DIFFTOOL='icdiff'

# Importing source
source "$ZDOTDIR/aliases"
source "$ZDOTDIR/functions"
source "$ZDOTDIR/exports"
source "$ZDOTDIR/nix"

# zsh settings
export DISABLE_AUTO_TITLE="true"
export COMPLETION_WAITING_DOTS="false"
export HIST_STAMPS="dd.mm.yyyy"
export HISTSIZE=5000
export SAVEHIST=5000
export HISTFILE="$HOME/.local/share/zsh/.zsh_history"
setopt HIST_IGNORE_SPACE
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# cd-ing settings
setopt auto_cd                                         # automatically cd if folder name and no command found
setopt auto_list                                       # automatically list choices on ambiguous completion
setopt auto_menu                                       # automatically use menu completion
setopt always_to_end                                   # move cursor to end if word had one match
setopt interactive_comments                            # allow comments in interactive shells
zstyle ':completion:*' menu select                     # select completions with arrow keys
zstyle ':completion:*' group-name ''                   # group results by category
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # non case sensitive complete
zstyle ':completion:*' list-colors "$LS_COLORS"
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion

# Tool Initialization
eval "$(zoxide init zsh --cmd j)"
eval "$(direnv hook zsh)"

# Starship prompt
eval "$(starship init zsh)"

# autocompletions
autoload -Uz compinit
zmodload zsh/complist
compinit

# autosuggestions settings
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC="true"

# sourcing plugins & themes
source "$ZDOTDIR/.zsh-custom/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
source "$ZDOTDIR/.zsh-custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"
source "$ZDOTDIR/.zsh-custom/plugins/fzf-tab/fzf-tab.plugin.zsh"
# source "$ZDOTDIR/.zsh-custom/plugins/.zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
# source "$HOME/.zsh-custom/plugins/.zsh-autopair/autopair.zsh"

# Pure Prompt
# fpath+=($HOME/.zsh-pure)
# # fpath+=("$(brew --prefix)/share/zsh/site-functions") # For Homebrew
# zstyle :prompt:pure:path color yellow
# zstyle :prompt:pure:git:branch color yellow
# zstyle :prompt:pure:user color cyan
# zstyle :prompt:pure:host color yellow
# zstyle :prompt:pure:git:branch:cached color red
# zstyle :prompt:pure:git:stash show yes
# autoload -U promptinit; promptinit
# prompt pure

# fzf-tab
zstyle ':completion:*:git-checkout:*' sort false # disable sorting for git-checkout
zstyle ':fzf-tab:*' use-fzf-default-opts yes # use fzf default options
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -1 --color=always $realpath' # preview for cd

ifsource(){
    [ -f "$1" ] && source "$1"
}

# Credentials
ifsource "$HOME/.credentials"

# source dir hashes
ifsource "$HOME/.local/share/zsh/.zsh_dir_hashes"

# load nix
ifsource /etc/profile.d/nix.sh
ifsource "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

# Source fzf
[ -d "$HOME/.nix-profile/share/fzf" ] &&
    source "$HOME/.nix-profile/share/fzf/completion.zsh" &&
    source "$HOME/.nix-profile/share/fzf/key-bindings.zsh"

# Use vim mode in zsh
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -v
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^H' backward-kill-word # ctrl+bspc
bindkey '^[^?' backward-kill-word # alt+bspc
# bindkey '^r' history-incremental-search-backward
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
bindkey "${terminfo[kcuu1]}" history-search-backward
bindkey "${terminfo[kcud1]}" history-search-forward
export KEYTIMEOUT=1

# setup direnv
eval "$(direnv hook zsh)"

# ,darkmode quiet # set dark or light mode
export ZSH_LOADED=1

# Launch Zellij automatically
# eval "$(zellij setup --generate-auto-start zsh)"
# if command -v zellij >/dev/null; then
#   if [[ -z "$ZELLIJ" && -z "$ZELLIJ_SESSION_NAME" && -z "$TMUX" ]]; then
#     if [[ -z "$SSH_CONNECTION" && $- == *i* ]]; then
#       exec zellij
#     fi
#   fi
# fi

# Prevent broken terminals by resetting to sane defaults after a command
ttyctl -f
