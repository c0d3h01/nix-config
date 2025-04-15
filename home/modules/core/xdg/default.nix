{ pkgs, ... }:
{
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gnome ];
      config = {
        common.default = "gnome";
      };
    };
  };
}
