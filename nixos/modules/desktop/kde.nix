{
  pkgs,
  lib,
  userConfig,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf (userConfig.windowManager == "kde") {
    # Plasma desktop environment configuration
    services.desktopManager.plasma6.enable = true;
    services.displayManager.sddm.enable = true;
    xdg.portal.extraPortals = [pkgs.kdePackages.xdg-desktop-portal-kde];

    # Enable hardware bluetooth
    hardware = {
      bluetooth.enable = true;
      bluetooth.powerOnBoot = true;
    };

    # Exclude unwanted KDE packages
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      kate
      kcalc
      konsole
      plasma-browser-integration
      partitionmanager
    ];
  };
}
