{
  config,
  pkgs,
  lib,
  ...
}:

{
  options = {
    myModules.NotebookTools = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Install set of notebook tools";
    };
  };

  config = lib.mkIf config.myModules.NotebookTools {
    environment.systemPackages = with pkgs; [
      drawio
      # geogebra
      wxmaxima
      rstudio
    ];
  };
}
