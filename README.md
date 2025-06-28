# localhost dotfiles

## Clean Installation

```bash
# Clone the repository
git clone https://github.com/c0d3h01/dotfiles.git
cd dotfiles

# Partition and format disk with Disko
sudo nix --experimental-features "nix-command flakes" run \
  github:nix-community/disko/latest -- \
  --mode destroy,format,mount ./machines/installer/disko.nix

# Only for low ram devices!
sudo btrfs filesystem mkswapfile --size 8G /mnt/swapfile
sudo chmod 600 /mnt/swapfile
sudo swapon /mnt/swapfile

# Install NixOS
sudo nixos-install --flake '.#devbox'
```

## Existing System

```bash
# Clone the repository
git clone https://github.com/c0d3h01/dotfiles.git
cd dotfiles

# Apply NixOS system configuration
sudo nixos-rebuild switch --flake '.#devbox'

# Apply Home manager user configuration
home-manager switch --flake '.#c0d3h01@devbox'
```
