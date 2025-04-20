{ config, userConfig, ... }:

{
  xdg.configFile = {
    "fastfetch" = {
      source = ./fastfetch;
      recursive = true;
      force = true;
    };
  };
}
