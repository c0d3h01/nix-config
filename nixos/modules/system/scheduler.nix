{
  pkgs,
  userConfig,
  lib,
  ...
}:
{
  services.scx = lib.mkIf userConfig.machineConfig.workstation.enable {
    enable = true;
    scheduler = "scx_lavd";
    package = pkgs.scx.rustscheds;
  };
}
