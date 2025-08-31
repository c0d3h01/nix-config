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
        figma-linux
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
        element-desktop
        signal-desktop
        libreoffice
        obsidian
        gimp
        anydesk
        qbittorrent
        electrum
        ledger-live-desktop
        arduino
        rpi-imager
      ]
      ++ lib.optionals userConfig.devStack.wine.enable [
        wineWowPackages.stable
        winetricks
      ];
  };
}
