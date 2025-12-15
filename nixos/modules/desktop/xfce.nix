{
  lib,
  userConfig,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf (userConfig.windowManager == "xfce") {
    nixpkgs.config.pulseaudio = true;
    services.xserver = {
      enable = true;
      desktopManager = {
        xterm.enable = false;
        xfce.enable = true;
      };
    };
    services.displayManager.defaultSession = "xfce";
  };
}
