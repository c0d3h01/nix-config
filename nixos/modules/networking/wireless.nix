{
  lib,
  userConfig,
  ...
}: let
  inherit (lib) mkIf;
  isenable = userConfig.machineConfig.networking.backend;
  iftrue = userConfig.machineConfig.server.enable;
in {
  config = mkIf iftrue {
    # enable wireless database, it helps keeping wifi speedy
    hardware.wirelessRegulatoryDatabase = true;

    networking.wireless = {
      # wpa_supplicant
      enable = isenable == "wpa_supplicant";

      # Allow user to manage networks via `nmcli` or GUI
      userControlled.enable = true;

      # Allow imperative commands like `iwlist scan`, `nmcli dev wifi connect`
      allowAuxiliaryImperativeNetworks = true;

      # wpa_supplicant: Save network config in /etc/NetworkManager/system-connections/
      extraConfig = ''
        update_config=1
      '';

      # iwd
      iwd = {
        enable = isenable == "iwd";

        settings = {
          Settings.AutoConnect = true;

          General = {
            # AddressRandomization = "network";
            # AddressRandomizationRange = "full";

            # Enable dynamic IP + IPv6 router-based config
            EnableNetworkConfiguration = true;
            RoamRetryInterval = 15;
          };

          Network = {
            EnableIPv6 = true;
            RoutePriorityOffset = 300;
          };
        };
      };
    };
  };
}
