{ config, lib, pkgs, ... }:

{
  systemd.oomd.enable = true;
  services.acpid.enable = true;

  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp
  };

  services.tlp = {
    enable = true;
    settings = {
      USB_AUTOSUSPEND = 1;
      CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };
  };

  powerManagement = {
    enable = true;
    powertop.enable = true;
    # cpuFreqGovernor = "schedutil";
  };
}
