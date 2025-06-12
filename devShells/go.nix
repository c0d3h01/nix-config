{ pkgs, ... }:

pkgs.mkShell {
  name = "go-devshell";
  buildInputs = with pkgs; [
    go
    gopls
    gotools
    golangci-lint
  ];
  shellHook = ''
    echo "🐹 Go development shell. Use 'go mod' for dependency management."
  '';
}
