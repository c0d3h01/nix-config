{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    go
    gopls
    gotools
    golangci-lint
  ];
}
