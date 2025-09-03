{
  pkgs,
  lib,
  userConfig,
  ...
}:
{
  config = lib.mkIf userConfig.machineConfig.workstation.enable {
    # Default browser
    programs.firefox.enable = true;

    programs.wireshark = {
      enable = true;
      package = pkgs.wireshark;
      dumpcap.enable = true;
      usbmon.enable = true;
    };

    environment.systemPackages =
      with pkgs;
      [
        ghostty
        android-studio
        vscode-fhs
        jetbrains.webstorm
        postman
        github-desktop
        drawio
        slack
        discord
        telegram-desktop
        zoom-us
        libreoffice
        obsidian
        anydesk
        qbittorrent
        ledger-live-desktop
        arduino
        rpi-imager
        wineWowPackages.stable
        winetricks
      ];
  };
}
