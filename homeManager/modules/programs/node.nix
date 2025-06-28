{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    nodejs
    yarn
    eslint
    prettierd
    bun
    pnpm
  ];
}
