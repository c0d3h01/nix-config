{
  pkgs,
  lib,
  userConfig,
  ...
}:
{
  # secrets management service
  services.gnome.gnome-keyring.enable = lib.mkForce true;

  networking = {
    # DNS servers (Cloudflare and Google DNS)
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "8.8.8.8"
      "8.8.4.4"
    ];

    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      plugins = [ pkgs.networkmanager-openvpn ];

      wifi = {
        inherit (userConfig.machineConfig.networking) backend;
        # use a random mac address on every boot, this can scew with static ip
        macAddress = "random";

        # Powersaving mode - Disabled
        powersave = lib.mkForce false;

        # MAC address randomization of a Wi-Fi device during scanning
        # scanRandMacAddress = true;
      };
    };
  };
}
