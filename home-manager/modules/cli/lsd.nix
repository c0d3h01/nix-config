{
  programs.lsd = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      classic = false;
      sorting = {
        column = "name";
        natural = true;
        dirs_first = true;
      };
      size = "human";
      date = "relative";
      icons.when = "auto";
      color.when = "auto";
      indicators = true;
      blocks = [
        "permission"
        "size"
        "date"
        "name"
      ];
    };
  };
}
