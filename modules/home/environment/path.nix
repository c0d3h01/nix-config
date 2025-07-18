{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.lists) optional;
in
{
  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
    "${config.home.homeDirectory}/.npm-global/bin"
    "${config.home.homeDirectory}/.rustup"
    "${config.home.homeDirectory}/.cargo/bin"
    "${config.home.homeDirectory}/.cargo/env"
    "${config.home.homeDirectory}/go/bin"
    "${config.home.homeDirectory}/bin"
    # I relocated this too the fish config, such that it would fix a issue where git would use the wrong version
    # "/etc/profiles/per-user/c0d3h01/bin" # needed for darwin
  ] ++ optional pkgs.stdenv.hostPlatform.isDarwin "$GHOSTTY_BIN_DIR";
}
