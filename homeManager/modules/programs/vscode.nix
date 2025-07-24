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
  options.programs.hm-vscode.enable = mkEnableOption "Visual Studio Code";

  config = mkIf config.programs.hm-vscode.enable {
    programs.vscode = {
      enable = true;
      package = wrap pkgs.vscode-fhs;
    };
  };
}
