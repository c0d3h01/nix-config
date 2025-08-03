{ pkgs, userConfig, ... }:
{
  services.resolved.enable = true;
  systemd.network.wait-online.enable = false;

  networking = {
    networkmanager = {
      enable = true;
      # wifi.powersave = false;
      dns = "systemd-resolved";
      plugins = [ pkgs.networkmanager-openvpn ];

      unmanaged = [
        "interface-name:tailscale*"
        "interface-name:br-*"
        "interface-name:rndis*"
        "interface-name:docker*"
        "interface-name:virbr*"
        "interface-name:vboxnet*"
        "interface-name:waydroid*"
        "type:bridge"
      ];

      wifi = {
        # this can be iwd or wpa_supplicant, use wpa_s until iwd support is stable
        backend = userConfig.machine.wireless-nets;

        # The below is disabled as my uni hated me for it
        # use a random mac address on every boot, this can scew with static ip
        # macAddress = "random";

        powersave = false;

        # MAC address randomization of a Wi-Fi device during scanning
        scanRandMacAddress = true;
      };
    };
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = false;
  };
}
