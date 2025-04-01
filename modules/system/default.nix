{ config
, pkgs
, specialArgs
, lib
, ...
}:
{
  imports = [
    ./audio.nix
    ./boot.nix
    ./desktop
    ./fonts.nix
    ./networking.nix
    ./security.nix
  ];

  # gnupg agent configuration
  # This is required for SSH support
  # and to use gpg-agent as a SSH agent
  programs = {
    gnupg.agent.enable = true;
    gnupg.agent.enableSSHSupport = false;
  };

  # Services configuration
  services = {
    # SSH support
    openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "prohibit-password";
        AllowUsers = [ "${specialArgs.username}" ];
      };
    };
    # Printing support
    printing = {
      enable = true;
      drivers = with pkgs; [ gutenprint hplip ];
    };
    avahi = {
      enable = true;
      openFirewall = true;
    };
  };

  # Ananicy service for process scheduling
  services.ananicy = {
    enable = true;
    settings = {
      apply_nice = true;
      check_freq = 10; # runs every seconds
      cgroup_load = true;
      type_load = true;
      rule_load = true;
      apply_ioclass = true;
      apply_ionice = true;
      apply_sched = true;
      apply_oom_score_adj = true;
      apply_cgroup = true;
      check_disks_schedulers = true;
    };
  };

  # Enable zram swap
  zramSwap = {
    enable = true;
    algorithm = "lz4";
    memoryPercent = 200;
    priority = 100;
  };

  # NixOS configuration
  nixpkgs = {
    config = lib.mkForce {
      allowUnfree = true;
      tarball-ttl = 0;
      android_sdk.accept_license = true;
    };
  };
  nix = {
    settings = lib.mkMerge [
      ({
        keep-outputs = true;
        keep-derivations = true;
        keep-going = true;
        builders-use-substitutes = true;
        accept-flake-config = true;
        http-connections = 0;
        auto-optimise-store = true;
        max-jobs = "auto";
        use-xdg-base-directories = true;
        experimental-features = [
          "nix-command"
          "flakes"
          "auto-allocate-uids"
        ];
      })
    ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
  };
}
