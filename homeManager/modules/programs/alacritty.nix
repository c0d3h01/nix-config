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
  programs.alacritty = lib.mkIf (userConfig.hm ? alacritty && userConfig.hm.alacritty) {
    enable = true;
    package = wrap pkgs.alacritty;
    theme = "solarized_dark";
    settings = { };
  };
}
