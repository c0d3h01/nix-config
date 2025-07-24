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
  options.programs.hm-nh.enable = mkEnableOption "nix OS's tool";

  config = mkIf config.programs.hm-nh.enable {
    programs.nh = {
      enable = true;
      clean = {
        dates = "weekly";
        extraArgs = "--keep 5 --keep-since 3d";
      };
    };
  };
}
