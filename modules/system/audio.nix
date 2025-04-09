{
  security.rtkit.enable = true;
  hardware.bluetooth = {
    enable = true;
    settings.General.Experimental = true;
  };

  services = {
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      # media-session.enable = true;
    };
  };
}
