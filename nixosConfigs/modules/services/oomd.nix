{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  systemd = {
    oomd = {
      enable = mkDefault true;
      enableRootSlice = true;
      enableUserSlices = true;
      enableSystemSlice = true;
      extraConfig = {
        "DefaultMemoryPressureDurationSec" = "20s";
      };
    };
  };
}
