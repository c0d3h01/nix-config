{ lib, userConfig, ... }:
let
  isLaptop = userConfig.machineConfig.laptop.enable;
in
{
  # ZRAM configuration
  zramSwap = lib.mkIf isLaptop {
    enable = true;
    priority = 1000;
    algorithm = "lz4";
    memoryPercent = 200;
  };
}
