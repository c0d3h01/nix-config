{ userConfig, pkgs, ... }:

{
  dconf.settings = {
    # GNOME Shell extensions
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "gsconnect@andyholmes.github.io"
        "dash2dock-lite@icedman.github.com"
        # "forge@jmmaranan.com"
        # "dash-to-dock@micxgx.gmail.com"
      ];
    };

    # Power settings
    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "interactive";
    };

    # # Night Light
    # "org/gnome/settings-daemon/plugins/color" = {
    #   night-light-enabled = true;
    #   night-light-temperature = 4000;
    #   night-light-schedule-from = "20.0";
    #   night-light-schedule-to = "8.0";
    # };

    # # Dask to Dock
    # "org/gnome/shell/extensions/dash-to-dock" = {
    #   dock-position = "BOTTOM";
    #   intellihide-mode = "ALL_WINDOWS";
    # };

    "org/gnome/shell/extensions/dash2dock-lite" = {
      calendar-icon = true;
      clock-icon = true;
      mounted-icon = true;
      open-app-animation = true;
      edge-distance = 0.48837209302325579;
      running-indicator-style = 1;
    };

    # interface
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = true;
      clock-show-weekday = true;
      clock-show-date = true;
      clock-format = "12h";
      # enable-animations = false;
      show-battery-percentage = true;
    };

    # touchpad
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
      natural-scroll = true;
      disable-while-typing = true;
    };

    # keyboard
    "org/gnome/desktop/peripherals/keyboard" = {
      numlock-state = true;
    };

    # workspaces
    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      edge-tiling = false;
      workspaces-only-on-primary = true;
    };

    # wallpaper
    # "org/gnome/desktop/background" = {
    #   picture-uri = "file:///home/${userConfig.username}/dotfiles/assets/wallpapers/Space-Nebula.png";
    #   picture-uri-dark = "file:///home/${userConfig.username}/dotfiles/assets/wallpapers/Space-Nebula.png";
    #   picture-options = "zoom";
    # };
  };

  # Configure XDG portals for the user
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gnome ];
    config.common.default = "gnome";
  };
}
