{ lib, config, pkgs, ... }:

{
  # Enable X server and GNOME
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.xserver.xkb.layout = "us";
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable dconf service for GNOME settings management
  programs.dconf.enable = true;

  # Virtual boxes
  virtualisation.libvirtd.enable = true;

  # Exclude unwanted GNOME packages
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-disk-utility
    gnome-backgrounds
    gnome-font-viewer
    gnome-music
    epiphany
    geary
    yelp
    baobab
    gnome-weather
    gnome-connections
    gnome-contacts
    gnome-system-monitor
  ];

  services.xserver.excludePackages = with pkgs; [
    xterm
  ];

  # Additional system packages
  environment.systemPackages = with pkgs; [
    gnome-photos
    gnome-tweaks
    gnome-boxes
    evolutionWithPlugins
    rhythmbox
    libreoffice
    kdePackages.kpat # Game

    # Theme pkgs
    palenight-theme
    numix-cursor-theme
    pkgs.papirus-icon-theme

    # Gnome Extensions
    gnomeExtensions.gsconnect
    gnomeExtensions.dash-to-dock
  ];

  home-manager.users.c0d3h01 = { pkgs, ... }: {
    dconf.settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          # gnome Extensions 
          "gsconnect@andyholmes.github.io"
          "dash-to-dock@micxgx.gmail.com"
        ];
      };

      # Set Yaru Red Dark for GTK apps
      "org/gnome/desktop/interface" = {
        gtk-theme = "palenight";
        icon-theme = "Papirus-Dark";
        cursor-theme = "Numix-Cursor";
        color-scheme = "prefer-dark";
        enable-hot-corners = false;
      };

      # Set wallpaper
      "org/gnome/desktop/background" = {
        picture-uri = "file://${config.users.users.c0d3h01.home}/dotfiles/assets/wallpaper.png";
        picture-uri-dark = "file://${config.users.users.c0d3h01.home}/dotfiles/assets/wallpaper.png";
      };

      # Set screensaver
      "org/gnome/desktop/screensaver" = {
        picture-uri = "file://${config.users.users.c0d3h01.home}/dotfiles/assets/wallpaper.png";
        primary-color = "#8a0707";
        secondary-color = "#000000";
      };
    };
  };
}
