{
  inputs,
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")

    inputs.disko.nixosModules.disko
    ./disko.nix
  ];

  # firmware updates
  services.fwupd.enable = true;

  boot.loader = {
    grub = lib.mkDefault {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev"; # For UEFI
      # useOSProber = true;
    };
    systemd-boot.enable = lib.mkDefault false;
    efi.canTouchEfiVariables = false;
    timeout = 5;
  };

  boot = {
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
    supportedFilesystems = [ "ntfs" ];

    kernelPackages = pkgs.linuxPackages_xanmod_stable;
    kernelParams = [
      "quiet"
      "nowatchdog"
      "loglevel=3"
      "mitigations=off"
      "splash"
    ];

    kernel.sysctl = {
      # "vm.swappiness" = 10;
      # "vm.vfs_cache_pressure" = 50;
      # "kernel.sched_autogroup_enabled" = 0;
      # "kernel.numa_balancing" = 0;
    };

    initrd = {
      verbose = false;
      kernelModules = [ ];
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usb_storage"
        "sd_mod"
      ];
    };
  };

  networking.useDHCP = lib.mkDefault true;
  networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;
  networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
