{
  pkgs,
  declarative,
  ...
}:

{
  imports = [
    ./dconf.nix
  ];

  # Enable Gnome, X server
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
  services.gnome.gnome-initial-setup.enable = false;

  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  # Exclude unwanted GNOME packages
  environment = {
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

  environment.systemPackages =
    with pkgs.gnomeExtensions;
    [
      dash2dock-lite
      # dash-to-dock
      # forge
    ]
    ++ (with pkgs; [
      gnome-photos
      gnome-tweaks
    ]);
}
