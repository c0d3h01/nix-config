{
  config,
  pkgs,
  lib,
  ...
}:

{
  options = {
    myModules.enableScientificTools = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Install set of notebook tools";
    };
  };

  config = lib.mkIf config.myModules.enableScientificTools {

    environment.systemPackages = with pkgs; [
      # Writing and notes
      tectonic # CLI – Minimal LaTeX compiler
      zathura # GUI – Lightweight PDF viewer (Vim-like)
      xournalpp # GUI – Handwritten notes and PDF annotation
      obsidian # GUI – Markdown-based note-taking
      pandoc # CLI – Document converter (md <-> pdf/tex/docx/etc.)

      # Math tools
      # sage # CLI/GUI – Full-featured math system
      gnuplot # CLI – Scriptable plotting tool

      # Diagrams and graphs
      inkscape # GUI – Vector graphics editor
      drawio # GUI – Flowcharts, UML, etc.
      graphviz # CLI – Dot-based graph drawing

      # Research workflow
      zotero # GUI – Reference manager
    ];
  };
}
