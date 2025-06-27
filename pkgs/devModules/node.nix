{
  config,
  pkgs,
  lib,
  ...
}:

{
  options = {
    myModules.node.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.myModules.node.enable {
    environment.systemPackages = with pkgs; [
      nodejs
      yarn
      eslint
      prettierd
      bun
      pnpm
    ];
  };
}
