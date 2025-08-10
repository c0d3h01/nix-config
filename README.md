# **c0d3h01's dotfiles**

- These are my personal dotfiles, managed with [Nix Flakes](https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake) and [Home Manager](https://nix-community.github.io/home-manager/).  

---

## Installation

### Apply Home Manager Configuration

```bash
# Run the following command to switch to your Home Manager configs directly
$ nix run github:nix-community/home-manager -- switch \
  --flake 'github:c0d3h01/dotfiles#c0d3h01@nixos'
```

### Optional: Local Clone

```bash
# clone to directory
$ git clone https://github.com/c0d3h01/dotfiles.git &&
  cd dotfiles

$ nix run github:nix-community/home-manager -- switch \
  --flake '.#c0d3h01@nixos'
```

---

## NixOS Clean Installation

```bash
# Clone the repository
$ git clone https://github.com/c0d3h01/dotfiles.git &&
  cd dotfiles

# Partition and format disk with Disko
$ sudo nix --experimental-features "nix-command flakes" run \
  github:nix-community/disko/latest -- \
  --mode destroy,format,mount \
  -- yes-wipe-all-disks \
  ./systems/c0d3h01/disko-btrfs.nix

# Only for low ram devices!
$ sudo btrfs filesystem mkswapfile --size 8G /mnt/swapfile &&
  sudo swapon /mnt/swapfile

# Install NixOS
# In the dotfiles has no root pass
$ sudo nixos-install --flake '.#c0d3h01' --no-root-passwd
```
