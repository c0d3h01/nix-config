{ config
, user
, lib
, ...
}: {

  system.autoUpgrade = {
    enable = true;
    dates = "daily";
    randomizedDelaySec = "45min";
    allowReboot = false;
    flake = "/home/${user.username}/dotfiles#${user.hostname}";
    flags = [
      "--update-input"
      "nixpkgs"
      "--commit-lock-file"
    ];
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      max-jobs = "auto";
      cores = 0; # Use all available cores
      builders = lib.mkForce "";
      trusted-users = [ "root" "${user.username}" ];
      experimental-features = [
        "nix-command"
        "flakes"
        "ca-derivations"
      ];
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };

    gc = {
      automatic = true;
      dates = "daily";
      randomizedDelaySec = "45min";
      options = "--delete-older-than 2d";
      persistent = true;
    };
  };
}
