{ declarative, pkgs, ... }:

{
  home-manager.users."${declarative.username}" = {
    dconf.settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          "gsconnect@andyholmes.github.io"
          "dash-to-dock@micxgx.gmail.com"
        ];
      };

      "org/gnome/settings-daemon/plugins/power" = {
        power-button-action = "Power Off";
        sleep-inactive-ac-type = "Power Off";
      };

      # Dask to Dock
      "org/gnome/shell/extensions/dash-to-dock" = {
        dock-position = "BOTTOM";
      };

      # interface
      "org/gnome/desktop/interface" = {
        enable-hot-corners = false;
        clock-show-weekday = true;
        clock-show-date = true;
        clock-format = "12h";
        enable-animations = true;
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
        workspaces-only-on-primary = true;
      };

      # wallpaper
      # "org/gnome/desktop/background" = {
      #   picture-uri = "file:///home/${declarative.username}/dotfiles/assets/wallpapers/Space-Nebula.png";
      #   picture-uri-dark = "file:///home/${declarative.username}/dotfiles/assets/wallpapers/Space-Nebula.png";
      #   picture-options = "zoom";
      # };
    };

    # Configure XDG portals for the user
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gnome ];
      config.common.default = "*";
    };
  };
}
