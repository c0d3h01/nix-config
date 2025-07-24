{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
in
{
  options.programs.hm-notion-app.enable = mkEnableOption "Notion Enhanced App";

  config = mkIf config.programs.hm-notion-app.enable {
    home.packages = with pkgs; [
      (callPackage ./patch { })
    ];
  };
}
