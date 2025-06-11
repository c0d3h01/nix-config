{
  # Enable Btrfs auto-scrub weekly (for data integrity)
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };

  # Scheduled Btrfs balance (for space efficiency)
  systemd.timers."btrfs-balance" = {
    enable = true;
    timerConfig = {
      OnCalendar = "weekly";
      RandomizedDelaySec = "1h";  # Spread load a bit
      Persistent = true;
    };
    wantedBy = [ "timers.target" ];
  };
  systemd.services."btrfs-balance" = {
    script = ''
      # Only run if system is on AC (laptop check)
      if command -v upower >/dev/null && upower -i $(upower -e | grep BAT) | grep -q 'state:\s*discharging'; then
        echo "On battery, skipping btrfs balance"
        exit 0
      fi

      # Start a limited balance (data and metadata chunks >75% usage)
      /run/current-system/sw/bin/btrfs balance start -dusage=75 -musage=75 -susage=75 -v --background --noflush /
    '';
    serviceConfig = {
      Type = "oneshot";
      Nice = 19;
      IOSchedulingClass = "idle";
      IOSchedulingPriority = 7;
      CPUWeight = 1;
    };
  };

  # Scheduled Btrfs trim
  services.fstrim = {
    enable = true;
    interval = "weekly";
  };
}