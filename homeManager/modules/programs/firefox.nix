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
  options.programs.hm-firefox.enable = mkEnableOption "Firefox Browser";

  config = mkIf config.programs.hm-firefox.enable {
    programs.firefox = {
      enable = true;
      package = wrap pkgs.firefox;
    };
  };
}
