{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    R # The main R language interpreter
    # rPackages.tidyverse # Collection of data science packages (ggplot2, dplyr, etc.)
    # rPackages.devtools # Tools for R package development
    # rPackages.shiny          # Web application framework for interactive R apps
    # rPackages.knitr          # Dynamic report generation (R code to documents)
    # rPackages.rmarkdown      # Reproducible documents mixing R code and markdown
  ];
}
