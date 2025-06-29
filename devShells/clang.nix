{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  name = "Clang Dev Shell";
  buildInputs = with pkgs; [
      gdb
      gcc
      gnumake
      cmake
      cmakeWithGui
      ninja
      clang
      pkg-config
  ];
  # shellHook = ''
  # '';
}
