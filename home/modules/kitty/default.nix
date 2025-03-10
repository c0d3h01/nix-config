{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      italic_font = "auto";
      bold_font = "auto";
      bold_italic_font = "auto";
      font_size = "13.0";

      foreground = "#c0b18b";
      background = "#262626";
      background_opacity = "0.9";
      selection_foreground = "#2f2f2f";
      selection_background = "#d75f5f";
      cursor = "#8fee96";
      cursor_shape = "block";
      cursor_blink_interval = "0.5";
      cursor_stop_blinking_after = "15.0";
      scrollback_lines = "9000";
      scrollback_pager = "less +G -R";
      wheel_scroll_multiplier = "5.0";
      click_interval = "0.5";
      select_by_word_characters = ":@-./_~?&=%+#";
      mouse_hide_wait = "0.5";
      enabled_layouts = "*";
      repaint_delay = "10";
      input_delay = "3";
      visual_bell_duration = "0.0";
      enable_audio_bell = "yes";
      open_url_modifiers = "ctrl+shift";
      open_url_with = "default";
      term = "xterm-kitty";
      window_border_width = "0";
      window_margin_width = "15";
      active_border_color = "#ffffff";
      inactive_border_color = "#cccccc";
      hide_window_decorations = "yes";
      macos_option_as_alt = "no";
      remember_window_size = "yes";
      confirm_os_window_close = "0";
      macos_titlebar_color = "background";
    };
    extraConfig = builtins.readFile ./nordtheme;
  };
}

