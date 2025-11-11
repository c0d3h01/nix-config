{
  pkgs,
  lib,
  userConfig,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = userConfig.machineConfig.workstation.apps;
in
{
  config = mkIf cfg {
    environment.systemPackages = with pkgs; [
      ghostty
      vscode-fhs
      postman
      github-desktop
      drawio
      vesktop
      telegram-desktop
      libreoffice-still
      arduino-core
    ];
  };
}
