{
  userConfig,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf userConfig.machineConfig.workstation {
    # AppImage support
    programs.appimage = {
      enable = true;
      binfmt = true;
    };
  };
}
