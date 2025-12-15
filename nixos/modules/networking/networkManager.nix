{
  lib,
  userConfig,
  ...
}: let
  inherit (lib) mkForce;
  cfg = userConfig.networking;
in {
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";

    wifi = {
      # Default is wpa_supplicant
      backend = "wpa_supplicant";

      # use a random mac address on every boot, this can scew with static ip
      # macAddress = "random";

      # Powersaving mode - Disabled
      powersave = mkForce false;

      # MAC address randomization of a Wi-Fi device during scanning
      scanRandMacAddress = false;
    };
  };
}
