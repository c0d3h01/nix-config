{ pkgs, ... }:

{
  # -*-[ Docker Setup ]-*-

  # Enable Docker Daemon and Utilities
  virtualisation.docker = {
    enable = true; # Enable the Docker daemon
    enableOnBoot = false; # Start Docker on system boot
    autoPrune.enable = true; # Automatically remove unused Docker resources
  };

  # Install CLI tools
  environment.systemPackages = with pkgs; [
    docker # The Docker CLI
    docker-compose # For managing multi-container applications
    # lazydocker     # A simple terminal UI for docker and docker-compose. Optional for visualization
  ];

  # Configure default memory and CPU limits
  virtualisation.docker.extraOptions = ''
    --default-shm-size=2g
    # --default-ulimit=nofile=1024:1024
  '';
}
