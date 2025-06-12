{ pkgs, ... }:

pkgs.mkShell {
  name = "python-devshell";
  buildInputs = with pkgs; [
    python312
    python312Packages.pip
    python312Packages.virtualenv
    python312Packages.flake8
    black
    mypy
    poetry
  ];
  shellHook = ''
    echo "🐍 Python development shell. Use 'poetry' or 'pip' as needed."
  '';
}
