{
  lib,
  pkgs,
  ...
}: {
  # Bootloader.
  boot.loader = {
    timeout = 5;
    efi.canTouchEfiVariables = true;

    systemd-boot = {
      enable = true;
      configurationLimit = 15;
    };
  };
}
