{
  lib,
  userConfig,
  ...
}:
let
  isLaptop = userConfig.machineConfig.type == "laptop";
in
{
  # Performance optimizations
  powerManagement = {
    enable = true;
    cpuFreqGovernor = lib.mkForce (
      if isLaptop then
        "schedutil" # Better balanced battery life
      else
        "performance" # Better performance for desktops
    );
  };

  # Power management
  services.power-profiles-daemon.enable = lib.mkIf isLaptop true;

  # # Auto CPU frequency scaling for laptops
  # services.auto-cpufreq = lib.mkIf isLaptop {
  #   enable = true;
  #   settings = {
  #     battery = {
  #       governor = "schedutil";
  #       turbo = "never";
  #     };
  #     charger = {
  #       governor = "performance";
  #       turbo = "auto";
  #     };
  #   };
  # };
}
