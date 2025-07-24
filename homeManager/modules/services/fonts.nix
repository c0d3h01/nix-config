{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
in
{
  options.programs.hm-fonts.enable = mkEnableOption "Font config";

  config = mkIf config.programs.hm-fonts.enable {
    home.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerd-fonts.jetbrains-mono
    ];

    fonts.fontconfig = {
      enable = true;

      defaultFonts = {
        serif = [
          "Noto Serif"
        ];
        sansSerif = [
          "Noto Sans"
        ];
        monospace = [
          "JetBrainsMono Nerd Font"
        ];
        emoji = [
          "Noto Color Emoji"
        ];
      };
    };
  };
}
