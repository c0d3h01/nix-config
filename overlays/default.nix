{
  config,
  system,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  nixpkgs.overlays = [
    # Nur for firefox extensions
    inputs.nur.overlays.default

    (final: prev: {
      # Stable Nixpkgs config
      stable = import inputs.nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
    })

    # (import ./overlay3)
  ];
}
