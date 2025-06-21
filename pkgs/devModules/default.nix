{
  pkgs,
  ...
}:

{
  imports = [
    ./docker.nix
    ./go.nix
    ./java.nix
    ./monitoring.nix
    ./mysql.nix
    ./node.nix
    ./podman.nix
    ./python.nix
    ./r.nix
    ./rust.nix
  ];

  # <-- Coustom modules -->
  myModules = {
    docker.enable = true;
    go.enable = true;
    java.enable = true;
    # monitoring.enable = true;
    # mysql.enable = true;
    node.enable = true;
    # podman.enable = true;
    python.enable = true;
    r.enable = true;
    rust.enable = true;
  };

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
    dumpcap.enable = true;
    usbmon.enable = true;
  };

  environment.systemPackages = with pkgs; [
    nodejs
    electron
    gdb
    gcc
    gnumake
    cmake
    ninja
    clang
    pkg-config
    jdk24
    gtk4
    glib
    pango
    gdk-pixbuf
    gobject-introspection
    libepoxy
  ];
}
