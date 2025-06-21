{
  config,
  pkgs,
  lib,
  ...
}:

{
  options = {
    myModules.go.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.myModules.go.enable {
    environment.systemPackages = with pkgs; [
      go
      gopls
      gotools
      golangci-lint
    ];
  };
}
