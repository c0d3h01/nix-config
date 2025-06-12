{ pkgs, ... }:

pkgs.mkShell {
  name = "java-devshell";
  buildInputs = with pkgs; [
    jdk24
    maven
    gradle
  ];
  shellHook = ''
    echo "☕ Java development shell. Use 'mvn' or 'gradle' as needed."
  '';
}
