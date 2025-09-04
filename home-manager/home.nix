{
  userConfig,
  lib,
  ...
}:

{
  imports = [
    ./modules
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Nvim
  modules.nvimToolchains.enable = true;

  home = {
    inherit (userConfig) username;
    homeDirectory = "/home/${userConfig.username}";
    stateVersion = lib.trivial.release;
  };
}
