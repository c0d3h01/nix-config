{
  lib,
  userConfig,
  ...
}:
let
  isLaptop = userConfig.machine ? hasBattery && userConfig.machine.hasBattery;
in
{
  # Performance optimizations
  powerManagement = {
    enable = true;
    cpuFreqGovernor = lib.mkDefault (
      if isLaptop then
        "schedutil" # Better balanced battery life
      else
        "performance" # Better performance for desktops
    );
  };

  # # Auto CPU frequency scaling for laptops
  # services.auto-cpufreq = lib.mkIf isLaptop {
  #   enable = true;
  #   settings = {
  #     battery = {
  #       governor = "powersave";
  #       turbo = "never";
  #     };
  #     charger = {
  #       governor = "performance";
  #       turbo = "auto";
  #     };
  #   };
  # };
}
