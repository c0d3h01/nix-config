{
  lib,
  userConfig,
  ...
}: let
  inherit (lib) mkIf;
  isLaptop = userConfig.machineConfig.laptop.enable;
in {
  config = mkIf isLaptop {
    # DBus service that provides power management support to applications.
    services.upower = {
      enable = true;
      percentageLow = 15;
      percentageCritical = 5;
      percentageAction = 3;
      criticalPowerAction = "Hibernate";
    };
  };
}
