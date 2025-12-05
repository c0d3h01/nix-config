{
  userConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf userConfig.machineConfig.workstation {
    services.dbus = {
      enable = true;
      implementation = "broker";
      packages = builtins.attrValues {inherit (pkgs) dconf gcr_4 udisks;};
    };
  };
}
