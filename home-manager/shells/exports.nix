{ lib, config, ... }:
{
  home.sessionVariables = {
    # Rust Build Environment
    CARGO_HOME = "${config.home.homeDirectory}/.cargo";
    CARGO_BUILD_JOBS = "4";

    # Go
    GOPATH = "${config.home.homeDirectory}/.local/share/go";
    GOBIN = "${config.home.homeDirectory}/.local/share/go/bin";

    # Python
    PYENV_ROOT = "${config.home.homeDirectory}/.local/share/pyenv";
    WORKON_HOME = "${config.home.homeDirectory}/.local/share/virtual-envs";

    # Node
    NVM_DIR = "${config.home.homeDirectory}/.local/nvm";

    # Android
    ANDROID_HOME = "${config.home.homeDirectory}/Android/Sdk";

    # Tool configs
    TS_MAXFINISHED = "13";
    DOCKER_BUILDKIT = "1";
    DELVE_EDITOR = ",emacs-no-wait";
    AIDER_GITIGNORE = "false";
    AIDER_CHECK_UPDATE = "false";
    K9S_CONFIG_DIR = "${config.home.homeDirectory}/.config/k9s";
  };

  programs.zsh.initContent = lib.mkOrder 1400 ''
    # Helper functions for path management
    add_to_path() { [[ -d "$1" && ":$PATH:" != *":$1:"* ]] && path=("$1" $path) }
    ifsource() { [[ -f "$1" ]] && source "$1" }

    # Rust environment
    ifsource "$HOME/.cargo/env"

    # Java (using mise if available)
    command -v mise &>/dev/null && export JAVA_HOME="$(mise where java 2>/dev/null)"

    # Android SDK
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
        export CHROME_EXECUTABLE="''${commands[chromium]:-''${commands[google-chrome]}}"
        add_to_path "$FLUTTER_HOME/bin"
        add_to_path "$HOME/.pub-cache/bin"
    fi

    # Go
    add_to_path "$GOBIN"

    # Python (pyenv)
    if [[ -d "$PYENV_ROOT" ]]; then
        add_to_path "$PYENV_ROOT/bin"
        eval "$(pyenv init --path 2>/dev/null)"
    fi

    # Node (lazy loaded)
    [[ -s "$NVM_DIR/nvm.sh" ]] && nvm() {
        unfunction nvm
        source "$NVM_DIR/nvm.sh"
        [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
        nvm "$@"
    }

    # Solana
    add_to_path "$HOME/.local/share/solana/install/active_release/bin"

    # Local bins
    add_to_path "$HOME/.local/bin"
    for bin in random helpers utils backpocket git jj docker kubernetes music tmux ai; do
        add_to_path "$HOME/.local/bin/$bin"
    done
    add_to_path "$HOME/.npm-global/bin"
    add_to_path "$HOME/bin"

    # Finalize PATH (remove duplicates)
    typeset -U path
    export PATH
  '';
}
