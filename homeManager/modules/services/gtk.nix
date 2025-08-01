{
  lib,
  userConfig,
  pkgs,
  ...
}:

{
  home.pointerCursor = lib.mkIf (userConfig.machine ? hasGUI && userConfig.machine.hasGUI) {
    gtk.enable = true;
    x11.enable = true;
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
  };

  # GTK theming
  gtk = lib.mkIf (userConfig.machine ? hasGUI && userConfig.machine.hasGUI) {
    enable = true;
    theme = {
      name = "Adwaita-Dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome-themes-extra;
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
}
