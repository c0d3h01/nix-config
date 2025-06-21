{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    myModules.python.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.myModules.python.enable {

    environment.systemPackages = with pkgs; [
      (pkgs.python313.withPackages (
        ps: with ps; [
          pip
          uv
          virtualenv
          jupyterlab
          sympy
          pygame
          numpy
          scipy
          pandas
          scikit-learn
          matplotlib
          torch
        ]
      ))
      pyright
      ruff
    ];
  };
}
