{
  userConfig,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./git
    ./programs
    ./shells
    ./system
    ./terminal
    ./variables.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
    inherit (userConfig) username;
    homeDirectory = "/home/${userConfig.username}";
    stateVersion = lib.trivial.release;
  };
}
