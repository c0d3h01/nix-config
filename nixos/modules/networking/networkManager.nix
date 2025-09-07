{
  pkgs,
  lib,
  userConfig,
  ...
}:
let
  cfg = userConfig.machineConfig.networking;
in
{
  # Ensures Wi-Fi adheres to your country's power/channel rules
  hardware.wirelessRegulatoryDatabase = true;

  networking = lib.mkIf (!cfg.wireless.enable) {
    enableIPv6 = true;

    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      plugins = [ pkgs.networkmanager-openvpn ];

      # unmanaged = [
      #   "interface-name:tailscale*"
      #   "interface-name:br-*"
      #   "interface-name:rndis*"
      #   "interface-name:docker*"
      #   "interface-name:virbr*"
      #   "interface-name:vboxnet*"
      #   "interface-name:waydroid*"
      #   "type:bridge"
      # ];

      wifi = {
        # Default is wpa_supplicant
        # inherit (userConfig.machineConfig.networking) backend;
        # use a random mac address on every boot, this can scew with static ip
        # macAddress = "random";
        # Powersaving mode - Disabled
        powersave = lib.mkForce false;
        # MAC address randomization of a Wi-Fi device during scanning
        scanRandMacAddress = true;
      };
    };
  };
}
