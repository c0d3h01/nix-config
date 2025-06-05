{
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };

  systemd.timers."btrfs-balance" = {
    enable = true;
    timerConfig.OnCalendar = "weekly";
    wantedBy = [ "timers.target" ];
  };
  systemd.services."btrfs-balance" = {
    script = ''
      /run/current-system/sw/bin/btrfs balance start -dusage=75 -musage=75 /
    '';
    serviceConfig = {
      Type = "oneshot";
      Nice = 19;
      IOSchedulingClass = "idle";
    };
  };
}