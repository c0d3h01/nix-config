{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
in
{
  options.programs.hm-gtk.enable = mkEnableOption "GTK Config";

  config = mkIf config.programs.hm-gtk.enable {
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    # GTK theming
    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-Dark";
        package = pkgs.gnome-themes-extra;
      };
      iconTheme = {
        name = "Tela-dark";
        package = pkgs.tela-icon-theme;
      };
      cursorTheme = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 24;
      };
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
    };
  };
}
