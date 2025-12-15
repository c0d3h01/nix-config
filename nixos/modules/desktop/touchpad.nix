{
  lib,
  userConfig,
  ...
}: let
  inherit (lib) mkIf;
  isLaptop = userConfig.laptop.enable;
in {
  config = mkIf isLaptop {
    # Input settings for libinput
    services.libinput = {
      enable = true;

      mouse = {
        accelProfile = "flat";
        accelSpeed = "0";
        middleEmulation = false;
      };

      # touchpad settings
      touchpad = {
        naturalScrolling = true;
        tapping = true;
        clickMethod = "clickfinger";
        disableWhileTyping = true;
      };
    };
  };
}
