{
  config,
  lib,
  pkgs,
  userConfig,
  ...
}:

{
  options = {
    myModules.podman.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.myModules.podman.enable {

    users.users.${userConfig.username}.extraGroups = [ "podman" ];
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    environment.systemPackages = with pkgs; [
      dive
      docker-compose
      podman-desktop
      kind
      kubectl
    ];
  };
}
