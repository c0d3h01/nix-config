{
  systemd = {
    oomd.enable = true;
    oomd.enableRootSlice = true;
    oomd.enableUserSlices = true;
  };

  services.fstrim = {
    enable = true;
    interval = "weekly";
  };
}
