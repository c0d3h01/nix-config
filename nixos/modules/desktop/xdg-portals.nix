{
  lib,
  pkgs,
  userConfig,
  ...
}: {
  xdg.portal = lib.mkIf userConfig.workstation {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
}
