{
  pkgs,
  ...
}:

{
  imports = [
    ./devModules
  ];

  # <-- Enable flatpak repo --> :
  # flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  # services.flatpak.enable = true;

  programs.appimage.enable = true;

  # <-- Environment packages -->
  environment.systemPackages = with pkgs; [
    # <-- Desktop applications -->
    firefox
    chromium

    # Notion Enhancer With patches
    (pkgs.callPackage ./notion-app-enhanced { })

    # Terminal
    ghostty

    # Code editors
    figma-linux
    vscode-fhs
    jetbrains.pycharm-community-bin
    # android-studio

    # Communication apps
    slack
    vesktop
    telegram-desktop
    zoom-us
    element-desktop
    signal-desktop

    # Common desktop apps
    postman
    github-desktop
    anydesk
    drawio
    electrum
    qbittorrent
    obs-studio
    libreoffice-qt6-fresh
    blender
    # gimp
    obsidian
  ];
}
