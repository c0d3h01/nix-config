{
  userConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) optionals;
  isWorkstation = userConfig.workstation;

  # DESKTOP APPLICATIONS
  desktopApps = with pkgs; [
    brave
    notion-app
    vscode-fhs
    postman
    github-desktop
    telegram-desktop
    signal-desktop-bin
    bitwarden-desktop
    discord
    gnuchess
    slack
    zoom-us
    drawio
    libreoffice-still
    wezterm
  ];

  # DEVELOPMENT & SYSTEM TOOLS
  devSystemTools = with pkgs; [
    # Development
    gdb
    mold
    sccache
    nil
    gcc
    clang
    zig
    rustup
    openjdk17
    lld

    # System Utilities
    ouch
    colordiff
    openssl
    inxi
    rsync
    iperf
    wget
    curl
  ];
in {
  environment.systemPackages = (optionals isWorkstation desktopApps) ++ devSystemTools;
}
