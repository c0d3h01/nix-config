# Variables
user := `whoami`
host := `hostname`

# Rebuild Home Manager configuration for a given host
home host:
    @echo "Switching Home Manager for {{host}}..."
    home-manager switch --flake ".#{{host}}"

# Rebuild NixOS system for a given host
rebuild host:
    @echo "Rebuilding NixOS for {{host}}..."
    sudo nixos-rebuild switch --flake ".#{{host}}"

# Garbage collect and optimize store
clean:
    @echo "Cleaning up Nix store..."
    sudo nix-collect-garbage -d
    nix store optimise

check:
    @echo "Checking for all systems..."
    nix flake check --all-systems
