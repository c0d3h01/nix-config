{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  inherit (config.lib.nixGL) wrap;
in
{
  options.programs.hm-wezterm.enable = mkEnableOption "Wezterm Terminal";

  config = mkIf config.programs.hm-wezterm.enable {
    programs.wezterm = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      package = wrap pkgs.wezterm;
    };
    xdg.configFile."wezterm" = {
      source = ./cfg;
      recursive = true;
    };
  };
}
