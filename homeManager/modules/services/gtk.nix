{ pkgs, ... }:

{
  # GTK theming
  gtk = {
    enable = true;
    # theme = {
    #   name = "Catppuccin-Mocha-Dark";
    #   package = pkgs.catppuccin-gtk;
    # };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
}
