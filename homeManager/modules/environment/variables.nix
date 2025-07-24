{
  self,
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  editor = "nvim";
  browser = "firefox";
  terminal = "ghostty";
  pager = "less";
  manpager = "less -R";
  flakePath = "${self}";

in
{
  options.programs.hm-env.enable = mkEnableOption "Home Environment";

  config = mkIf config.programs.hm-env.enable {
    home.sessionVariables = {
      EDITOR = editor;
      GIT_EDITOR = editor;
      VISUAL = editor;
      BROWSER = browser;
      TERMINAL = terminal;
      SYSTEMD_PAGERSECURE = "true";
      PAGER = pager;
      MANPAGER = manpager;
      FLAKE = flakePath;
      NH_FLAKE = flakePath;
      DO_NOT_TRACK = 1;
    };
  };
}
