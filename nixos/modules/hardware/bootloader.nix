{
  lib,
  userConfig,
  pkgs,
  ...
}: let
  inherit (lib) mkForce mkDefault;
  inherit (userConfig.machineConfig) bootloader;
  isSystemdBoot = bootloader == "systemd";
  isGrub = bootloader == "grub";
in {
  boot.loader = {
    timeout = mkForce 5;

    efi = {
      canTouchEfiVariables = mkDefault true;
      efiSysMountPoint = "/boot";
    };

    # Systemd-boot configuration
    systemd-boot = {
      enable = mkDefault isSystemdBoot;
      configurationLimit = 15;
      memtest86.enable = true;
      consoleMode = "max";
      editor = false;
    };

    # GRUB configuration
    grub = {
      enable = mkDefault isGrub;
      efiSupport = true;
      devices = ["nodev"];
      useOSProber = true;
      memtest86.enable = true;
      configurationName = "NixOS - c0d3h01";
      theme = pkgs.nixos-grub2-theme;
    };
  };
}
