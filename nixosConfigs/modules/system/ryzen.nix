{
  # https://bbs.archlinux.org/viewtopic.php?id=273440
  hardware.rasdaemon.enable = true;
  services.journald = {
    storage = "persistent";
    extraConfig = ''
      ForwardToSyslog=yes
    '';
  };
}
