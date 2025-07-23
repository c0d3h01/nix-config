{
  description = "Home Manager Flake for Dotfiles";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    sops.url = "github:c0d3h01/sops-nix";
    sops.inputs.nixpkgs.follows = "nixpkgs";
    nixgl.url = "github:c0d3h01/nixGL";
    nixgl.inputs.nixpkgs.follows = "nixpkgs";
    spicetify.url = "github:Gerg-L/spicetify-nix";
    spicetify.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      username = "c0d3h01";
      hostname = "fedora";
      homeDirectory = "/home/${username}";
      homeModule = ./homeManager;
    in
    {
      # Nix Formatter
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-tree;

      # Home Manager Configurations
      homeConfigurations."${username}@${hostname}" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = system;
          config.allowUnfree = true;
        };
        extraSpecialArgs = {
          inherit
            inputs
            self
            username
            hostname
            homeDirectory
            ;
          nixgl = inputs.nixgl;
        };
        modules = [ homeModule ];
      };
    };
}
