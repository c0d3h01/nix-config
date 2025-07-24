{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  inherit (config.lib.nixGL) wrap;
in
{
  options.programs.hm-ghostty.enable = mkEnableOption "Ghostty Terminal";

  config = mkIf config.programs.hm-ghostty.enable {
    programs.ghostty = {
      enable = true;
      package = wrap pkgs.ghostty;
      enableZshIntegration = true;

      settings = {
        font-family = "";
        font-size = 12;
        theme = "catppuccin-mocha"; # Belafonte Night
        mouse-hide-while-typing = true;
        gtk-titlebar = false;
        background-opacity = 0.85;
        background-blur-radius = 20;
        macos-option-as-alt = true;
        macos-non-native-fullscreen = "visible-menu";

        keybind = [
          "ctrl+c=copy_to_clipboard"
          "ctrl+v=paste_from_clipboard"
          "ctrl+shift+c=copy_to_clipboard"
          "ctrl+shift+v=paste_from_clipboard"
          "ctrl+zero=reset_font_size"
          "ctrl+q=quit"
          "ctrl+shift+comma=reload_config"
          "ctrl+k=clear_screen"
          "ctrl+n=new_window"
          "ctrl+w=close_surface"
          "ctrl+shift+w=close_window"
          "ctrl+t=new_tab"
          "ctrl+shift+left_bracket=previous_tab"
          "ctrl+shift+right_bracket=next_tab"
          "ctrl+d=new_split:right"
          "ctrl+shift+d=new_split:down"
          "ctrl+right_bracket=goto_split:next"
          "ctrl+left_bracket=goto_split:previous"
        ];
      };
    };
  };
}
