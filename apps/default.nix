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

  programs.appimage = {
    enable = true;
    binfmt = true;
    package = pkgs.appimage-run.override {
      extraPkgs = pkgs: [
        pkgs.ffmpeg
        pkgs.imagemagick
      ];
    };
  };

  myModules = {
    # docker.enable = true;
    # monitoring.enable = true;
    # mysql.enable = true;
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

  programs.direnv = {
    enable = true;
    silent = true;
    nix-direnv.enable = true;
    loadInNixShell = true;
    enableZshIntegration = true;
  };

  # Environment packages
  environment.systemPackages =
    let
      Apps = with pkgs; [
        # Browser
        firefox
      ];
    in
    Apps;
}
