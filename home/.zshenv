# Nix profile to PATH and XDG_DATA_DIRS
export PATH="$HOME/.nix-profile/bin:$PATH"
export XDG_DATA_DIRS="$HOME/.nix-profile/share:/usr/share:$XDG_DATA_DIRS"
