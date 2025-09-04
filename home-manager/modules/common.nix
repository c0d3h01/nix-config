{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    # Terminal Utilities
    tmux
    xclip
    curl
    wget
    tree
    stow
    zellij
    bat
    file
    icdiff
    tea
    less
    procs
    lsd
    glances
    fzf
    jj # JSON Stream Editor
    cheat # CheatSheet
    bottom
    just
    tree-sitter # Parser generator tool
    gdu # Disk usage analyzer CLI
    starship
    imagemagick

    # Notion App with patch infinity loading
    (callPackage ./notion-app { })

    # Language Servers
    lua-language-server
    nil
  ];
}
