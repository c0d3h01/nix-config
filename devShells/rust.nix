{ pkgs, ... }:

pkgs.mkShell {
  name = "rust-devshell";
  buildInputs = with pkgs; [
    rustup
    cargo
    rustc
    rustfmt
    clippy
  ];
  shellHook = ''
    echo "🦀 Rust development shell. Run 'rustup default stable' for default toolchain."
  '';
}
