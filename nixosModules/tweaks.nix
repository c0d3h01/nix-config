{ lib, ... }:

{
  powerManagement.powertop.enable = lib.mkDefault true;
  powerManagement.cpuFreqGovernor = lib.mkDefault "schedutil";
  services.thermald.enable = lib.mkDefault true;
  services.earlyoom.enable = lib.mkDefault true;
  services.oomd.enable = true;
}
