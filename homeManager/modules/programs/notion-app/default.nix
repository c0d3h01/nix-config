{
  lib,
  userConfig,
  pkgs,
  ...
}:

{
  home.packages =
    with pkgs;
    lib.mkIf (userConfig.machine ? hasGUI && userConfig.machine.hasGUI) [
      (callPackage ./patch { })
    ];
}
