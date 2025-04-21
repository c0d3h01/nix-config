{
  lib,
  pkgs,
  config,
  ...
}:
{
  gtk = {
    enable = true;

    cursorTheme = lib.mkForce {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };

    iconTheme = lib.mkForce {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = lib.mkForce {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };

    gtk3.extraConfig = lib.mkForce {
      "gtk-application-prefer-dark-theme" = true;
    };

    gtk4.extraConfig = lib.mkForce {
      "gtk-application-prefer-dark-theme" = true;
    };
  };
}
