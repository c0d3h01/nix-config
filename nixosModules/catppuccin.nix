{
  inputs,
  declarative,
  pkgs,
  lib,
  config,
  ...
}:

let
  theme = {
    flavor = "mocha"; # Options: "mocha", "macchiato", "frappe", "latte"
    accent = "mauve"; # Options: "blue", "flamingo", "green", ...
    size = "compact"; # "standard", "compact"
    cursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };

  catppuccinGtkTheme = inputs.catppuccin.packages.${pkgs.system}.gtk.override {
    flavor = theme.flavor;
    accents = [ theme.accent ];
    size = theme.size;
    tweaks = [ "rimless" ];
  };

in
{
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  # System-wide Catppuccin theme
  catppuccin = {
    enable = true;
    flavor = theme.flavor;
    accent = theme.accent;
  };

  catppuccin.tty = {
    enable = true;
    flavor = theme.flavor;
  };

  # Home Manager user config
  home-manager.users.${declarative.username} =
    { config, pkgs, ... }:
    {
      imports = [
        inputs.catppuccin.homeModules.catppuccin
      ];

      # Home-level Catppuccin settings (GUI, shells, etc)
      catppuccin = {
        enable = true;
        flavor = theme.flavor;
        accent = theme.accent;
      };

      # GTK theming
      gtk = {
        enable = true;
        theme = {
          name = catppuccinGtkTheme.name;
          package = catppuccinGtkTheme;
        };
        iconTheme = {
          name = "Papirus-Dark";
          package = pkgs.papirus-icon-theme;
        };
        gtk2.extraConfig = ''
          gtk-application-prefer-dark-theme = 1
        '';
        gtk3.extraConfig = {
          gtk-application-prefer-dark-theme = 1;
        };
        gtk4.extraConfig = {
          gtk-application-prefer-dark-theme = 1;
        };
      };

      # Cursor (pointer) theme
      home.pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        package = theme.cursor.package;
        name = theme.cursor.name;
        size = theme.cursor.size;
      };

      # GNOME/GTK session settings
      dconf.settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          icon-theme = "Papirus-Dark";
          cursor-theme = theme.cursor.name;
          cursor-size = theme.cursor.size;
        };
      };

      # Catppuccin for terminal emulator
      catppuccin.kitty.enable = true;

      programs.vscode = {
        enable = true;
        profiles.default.extensions = with pkgs.vscode-extensions; [
          catppuccin.catppuccin-vsc
          catppuccin.catppuccin-vsc-icons
        ];
        profiles.default.userSettings = {
          "workbench.colorTheme" = "Catppuccin Mocha";
          "workbench.iconTheme" = "catppuccin-mocha";
        };
      };
    };
}
