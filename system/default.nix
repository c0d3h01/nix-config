{ userConfig, ... }:

{
  imports = [
    ./applications
    ./development
    ./laptop
    ./modules
  ];

  system.stateVersion = userConfig.stateVersion;
  networking.hostName = userConfig.hostname;
}
