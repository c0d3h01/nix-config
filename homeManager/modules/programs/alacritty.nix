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
  options.programs.hm-alacritty.enable = mkEnableOption "Alacritty Terminal";

  config = mkIf config.programs.hm-alacritty.enable {
    programs.alacritty = {
      enable = true;
      package = wrap pkgs.alacritty;
      theme = "solarized_dark";
      settings = { };
    };
  };
}
