{ config
, pkgs
, lib
, ...
}:
{
  imports = [ ./devtools ];

  services = {
    flatpak.enable = false;
  };

  # Development environment packages
  environment.systemPackages =
    let
      # Group packages by category for better organization
      devTools = with pkgs; [
        # Utilities

        # Editors and IDEs
        vscodium-fhs
        vscode-fhs
        jetbrains.webstorm

        # Version control
        github-desktop

        # JavaScript/TypeScript
        nodejs
        nodePackages.node2nix

        # C/C++
        gcc
        gdb
        clang
        gnumake
        cmake
        ninja

        # Graphics libraries
        glib
        glfw
        glew
        glm
        sfml

        # GTK development tools
        gtk3
        gtk4
        gobject-introspection
        pkg-config
        gtkmm4 # C++ bindings for GTK4
        gtkmm3 # C++ bindings for GTK3

        # API Development
        postman
      ];

      communicationApps = with pkgs; [
        discord
        telegram-desktop
        slack
        zoom-us
        element-desktop
      ];

      desktopApps = with pkgs; [
        # Custom patched Notion
        (pkgs.callPackage ./notion-app-enhanced { })
        libreoffice
        tor-browser
        spotify
        transmission_4-gtk
        google-chrome
        anydesk
      ];

      networkingTools = with pkgs; [
        metasploit
        nmap
        wireshark
        tcpdump
      ];

      androidTools = with pkgs; [
        flutter
        dart
        openjdk
        gradle
        kotlin
        go
      ];
    in
    devTools ++ communicationApps ++ desktopApps ++ networkingTools ++ androidTools;
}
