{ config
, lib
, pkgs
, ...
}:
{
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      dejavu_fonts
      hack-font
      twitter-color-emoji
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = lib.mkForce [ "DejaVu Serif" ];
        sansSerif = lib.mkForce [ "DejaVu Sans" ];
        monospace = lib.mkForce [ "Hack" ];
        emoji = lib.mkForce [ "Twitter Color Emoji" ];
      };
    };
  };
}
