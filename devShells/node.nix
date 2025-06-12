{ pkgs, ... }:

pkgs.mkShell {
  name = "node-devshell";
  buildInputs = with pkgs; [
    nodejs
    yarn
    eslint
    prettierd
  ];
  shellHook = ''
    echo "🟩 Node.js development shell. Use 'npm' or 'yarn' as needed."
  '';
}
