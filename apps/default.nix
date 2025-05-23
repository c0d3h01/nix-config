{
  pkgs,
  ...
}:

{
  imports = [
    ./tools
  ];

  # Enable flatpak repo : flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  # services.flatpak.enable = true;

  programs.appimage.enable = true;
  # programs.adb.enable = true;

  myModules = {
    androidtools.enable = true;
    # docker.enable = true;
    monitoring.enable = true;
    mysql.enable = true;
    podman.enable = true;
    python.enable = true;
    r.enable = true;
    rust.enable = true;
  };

  # Environment packages
  environment.systemPackages =
    let
      Apps = with pkgs; [
        # Browser
        brave

        # -+ Common Developement tools
        nodejs
        yarn

        # Electron tools
        electron

        # C/C++
        gdb
        glib
        gcc
        clang
        gnumake
        cmake
        ninja
        clang-tools

        # Gtk tools
        pkg-config
      ];
    in
    Apps;
}
