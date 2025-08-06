{
  lib,
  userConfig,
  ...
}:
{

  # Ensures Wi-Fi adheres to your country's power/channel rules
  hardware.wirelessRegulatoryDatabase = true;

  # === GUI Tool for Managing Secrets (WiFi passwords, SSH keys) ===
  programs.seahorse.enable = true;

  # Enable MAC randomization during scanning (good for privacy)
  networking.networkmanager.wifi.scanRandMacAddress = true;

  networking.wireless = {
    # wpa_supplicant
    enable = userConfig.machineConfig.networking.backend == "wpa_supplicant";

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
      enable = userConfig.machineConfig.networking.backend == "iwd";

      settings = {
        Settings.AutoConnect = true;

        General = {
          # more things that my uni hates me for
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
}
