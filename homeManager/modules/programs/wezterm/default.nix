{
  userConfig,
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.lib.nixGL) wrap;
in
{
  programs.wezterm = lib.mkIf (userConfig.machine ? hasGUI && userConfig.machine.hasGUI) {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    package = wrap pkgs.wezterm;
  };
  xdg.configFile."wezterm" = {
    source = ./cfg;
    recursive = true;
  };
}
