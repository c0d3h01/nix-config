{ config, userConfig, ... }:

{
  xdg.configFile = {
    "fastfetch" = {
      source = ./fastfetch;
      recursive = true;
      force = true;
    };

    "kitty" = {
      source = ./kitty;
      recursive = true;
      force = true;
    };

    "nvim" = {
      source = ./nvim;
      recursive = true;
      force = true;
    };
  };
}
