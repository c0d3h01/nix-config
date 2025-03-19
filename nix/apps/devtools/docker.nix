{ config, pkgs, username, ... }:

{
  # -*-[ Docker Setup ]-*-
  # Enable Docker Daemon and Utilities
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    autoPrune.enable = true; # Automatically remove unused Docker resources
  };

  # Install CLI tools
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    lazydocker
  ];

  users.users.${username}.extraGroups = [ "docker" ];

  # Configure default memory and CPU limits
  virtualisation.docker.extraOptions = ''
    --default-shm-size=2g
    # --default-ulimit=nofile=1024:1024
  '';
}
