{
  pkgs,
  userConfig,
  lib,
  ...
}: {
  services.scx = lib.mkIf userConfig.workstation {
    enable = true;
    scheduler = "scx_bpfland";
    package = pkgs.scx.rustscheds;
  };
}
