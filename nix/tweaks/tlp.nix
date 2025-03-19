{ ... }:

{
  # Disable power-profiles-daemon to avoid conflicts with TLP
  services.power-profiles-daemon.enable = false;

  services.tlp = {
    enable = true;

    settings = {
      # CPU scaling governor (performance on AC, powersave on battery)
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "performance";

      # Energy performance policy (balanced settings for efficiency)
      CPU_ENERGY_PERF_POLICY_ON_BAT = "performance";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      # CPU driver operation mode (active for both AC and battery)
      CPU_DRIVER_OPMODE_ON_AC = "active";
      CPU_DRIVER_OPMODE_ON_BAT = "active";

      # Wi-Fi power settings (kept on for both AC and battery)
      WIFI_PWR_ON_AC = "auto";
      WIFI_PWR_ON_BAT = "auto";

      # Runtime power management (automatic power savings)
      RUNTIME_PM_ON_AC = "auto";
      RUNTIME_PM_ON_BAT = "auto";

      # CPU performance limits (higher on AC, reduced on battery)
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 100;

      # Turbo boost settings (enabled on AC, disabled on battery)
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 1;
      CPU_HWP_DYN_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 1;

      # Sleep mode settings (deep sleep for better power saving)
      MEM_SLEEP_ON_AC = "deep";
      MEM_SLEEP_ON_BAT = "deep"; #Deep sleep on AC since it is always connected

      # Platform power profile (performance on AC, low-power on battery)
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "performance";

      # AMD GPU power settings (high performance on AC, power saving on battery)
      RADEON_DPM_STATE_ON_AC = "performance";
      RADEON_DPM_STATE_ON_BAT = "performance";
      RADEON_POWER_PROFILE_ON_AC = "high";
      RADEON_POWER_PROFILE_ON_BAT = "high";

      # Disable scheduler power saving for better performance
      SCHED_POWERSAVE_ON_AC = 0;
      SCHED_POWERSAVE_ON_BAT = 0;

      # Disable USB autosuspend
      USB_AUTOSUSPEND = 0;
    };
  };
}
