#!/usr/bin/env zsh

# Helper functions
add_to_path() { [[ -d "$1" && ":$PATH:" != *":$1:"* ]] && path=("$1" $path) }
ifsource() { [[ -f "$1" ]] && source "$1" }

# Rust Build Environment
export CARGO_HOME="$HOME/.cargo"
ifsource "$HOME/.cargo/env"
ifsource "$HOME/.cargo/bin"
export CARGO_BUILD_JOBS=4
export CARGO_INCREMENTAL=1
export RUSTFLAGS="-C link-arg=-fuse-ld=mold -C target-cpu=native"
export CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER=clang
export CARGO_PROFILE_DEV_CODEGEN_UNITS=16
export CARGO_PROFILE_DEV_DEBUG=1
export CARGO_PROFILE_DEV_INCREMENTAL=true
export CARGO_PROFILE_DEV_BUILD_OVERRIDE_OPT_LEVEL=3
export CARGO_PROFILE_RELEASE_CODEGEN_UNITS=1
export CARGO_PROFILE_RELEASE_LTO="thin"
export CARGO_PROFILE_RELEASE_OPT_LEVEL=3
export CARGO_PROFILE_RELEASE_STRIP="symbols"
export CARGO_PROFILE_RELEASE_DEBUG=0
export CARGO_PROFILE_RELEASE_INCREMENTAL=false
export CARGO_PROFILE_RELEASE_PANIC="abort"
export CARGO_NET_RETRY=2
export CARGO_TERM_PROGRESS_WHEN=auto

# Java
command -v mise &>/dev/null && export JAVA_HOME="$(mise where java 2>/dev/null)"

# Android
if [[ -d "$HOME/Android/Sdk" ]]; then
    export ANDROID_HOME="$HOME/Android/Sdk"
    export ANDROID_SDK_ROOT="$ANDROID_HOME"
    export NDK_HOME="$ANDROID_HOME/ndk"
    add_to_path "$ANDROID_HOME/platform-tools"
    add_to_path "$ANDROID_HOME/emulator"
    add_to_path "$ANDROID_HOME/build-tools/36.0.0"
    add_to_path "$NDK_HOME"
fi

# Flutter
if [[ -d "$HOME/Android/flutter" ]]; then
    export FLUTTER_HOME="$HOME/Android/flutter"
    export CHROME_EXECUTABLE="${commands[chromium]:-${commands[google-chrome]}}"
    add_to_path "$FLUTTER_HOME/bin"
    add_to_path "$HOME/.pub-cache/bin"
fi

# Go
export GOPATH="$HOME/.local/share/go"
export GOBIN="$GOPATH/bin"
add_to_path "$GOBIN"

# Python
export PYENV_ROOT="$HOME/.local/share/pyenv"
export WORKON_HOME="$HOME/.local/share/virtual-envs"
if [[ -d "$PYENV_ROOT" ]]; then
    add_to_path "$PYENV_ROOT/bin"
    eval "$(pyenv init --path 2>/dev/null)"
fi

# Nix
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}

# Node (lazy loaded)
export NVM_DIR="$HOME/.local/nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && nvm() {
    unfunction nvm
    source "$NVM_DIR/nvm.sh"
    [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
    nvm "$@"
}

# Other tools
add_to_path "$HOME/.local/share/solana/install/active_release/bin"

# Local bins
add_to_path "$HOME/.local/bin"
for bin in random helpers utils backpocket git jj docker kubernetes music tmux ai; do
    add_to_path "$HOME/.local/bin/$bin"
done
add_to_path "$HOME/.npm-global/bin"
add_to_path "$HOME/bin"

# Tool configs
export TS_MAXFINISHED=13
# export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git --color=always'
# export FZF_DEFAULT_OPTS='--color=bg+:#3c3836,bg:#32302f,spinner:#fb4934,hl:#928374,fg:#ebdbb2,header:#928374,info:#8ec07c,pointer:#fb4934,marker:#fb4934,fg+:#ebdbb2,prompt:#fb4934,hl+:#fb4934'
export DOCKER_BUILDKIT=1
export DELVE_EDITOR=",emacs-no-wait"
export AIDER_GITIGNORE=false
export AIDER_CHECK_UPDATE=false
export K9S_CONFIG_DIR="$HOME/.config/k9s"

# Finalize
typeset -U path
export PATH