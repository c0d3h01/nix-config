bootstrap:
    sudo nix --experimental-features "nix-command flakes" run \
        github:nix-community/disko/latest -- \
        --mode destroy,format,mount ./machines/installer/disko.nix
    just swapfileon
    sudo nixos-install --flake '.#neuro' --no-root-passwd

switch:
    sudo nixos-rebuild switch --flake '.#neuro'

home:
    home-manager switch --flake '.#c0d3h01@neuro'

test:
    nixos-rebuild test --flake '.#neuro'

help:
    @echo "Available commands:"
    @echo "  bootstrap - Prepare the system for NixOS installation"
    @echo "  switch - Rebuild and switch to the new configuration"
    @echo "  home - Apply home-manager configuration"
    @echo "  test - Test the current configuration"
    @echo "  help - Show this help message"
