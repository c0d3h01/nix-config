{
  config,
  pkgs,
  lib,
  ...
}:

{
  options = {
    myModules.java.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.myModules.java.enable {
    environment.systemPackages = with pkgs; [
      jdk24
      maven
      gradle
    ];
  };
}
