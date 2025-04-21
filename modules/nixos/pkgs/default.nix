{ pkgs, ... }:

{
  imports = [ ./development ];

  # Flatpak apps support
  services.flatpak.enable = true;

  # VirtualMachine
  # virtualisation.libvirtd.enable = true;
  # users.users.${userConfig.username}.extraGroups = [ "libvirtd" ];

  # Allow running dynamically linked binaries
  programs.nix-ld.enable = true;

  # Environment packages
  environment.systemPackages =
    let
      stablePkgs = with pkgs.stable; [
      ];

      unstablePkgs = with pkgs; [
        # Browser
        brave

        # Notion Enhancer With patches
        (pkgs.callPackage ./notion-app-enhanced { })

        # Editors and IDEs
        vscode-fhs

        # Developement desktop apps
        postman
        github-desktop

        # Communication apps
        vesktop
        telegram-desktop
        zoom-us

        # Common desktop apps
        anydesk

        # -+ Common Developement tools
        nodejs

        # C/C++
        gdb
        clang
        gnumake
        cmake
        ninja

        # Gtk tools
        pkg-config

        # Android Tools
        flutter
        openjdk
      ];
    in
    stablePkgs ++ unstablePkgs;
}
