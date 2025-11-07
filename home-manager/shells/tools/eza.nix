{ config, ... }:
{
  programs.eza = {
    enable = true;
    theme = "catppuccin";
    icons = "auto";
    enableZshIntegration = true;
    enableIonIntegration = true;
    extraOptions = [
      "--group"
      "--group-directories-first"
      "--header"
      "--no-permissions"
      "--octal-permissions"
    ];
  };
}
