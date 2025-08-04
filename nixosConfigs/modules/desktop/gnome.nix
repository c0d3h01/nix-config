{
  pkgs,
  config,
  lib,
  userConfig,
  ...
}:
let
  inherit (lib) mkIf;
in
{
  config = mkIf (userConfig.desktop.windowManager == "gnome") {

    services = {
      # GNOME desktop environment configuration
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;

      xserver = {
        # Disable xterm
        desktopManager.xterm.enable = false;
        excludePackages = [ pkgs.xterm ];
      };
    };

    # Exclude unwanted GNOME packages
    environment = {
      systemPackages = with pkgs; [
        gnome-tweaks
        gnome-photos
        thunderbird
        rhythmbox
      ];

      gnome.excludePackages = with pkgs; [
        gnome-tour
        gnome-font-viewer
        epiphany
        yelp
        baobab
        gnome-music
        gnome-remote-desktop
        gnome-usage
        gnome-console
        gnome-contacts
        gnome-weather
        gnome-maps
        gnome-connections
        gnome-system-monitor
        gnome-user-docs
        geary
      ];
    };
  };
}
