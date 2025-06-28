{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    # jdk24
    semeru-bin
    maven
    gradle
  ];
}
