{
  description = "c0d3h01 dotfiles";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nixcord.url = "github:kaylorben/nixcord";
    stylix.url = "github:danth/stylix";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    { self
    , nixpkgs
    , nixpkgs-stable
    , agenix
    , home-manager
    , nur
    , ...
    }@inputs:
    let
      # System, User configurations
      system = "x86_64-linux";

      # Shared arguments for modules
      specialArgs = {
        inherit system agenix;
        inputs = self.inputs;

        username = "c0d3h01";
        hostname = "NixOS";
        useremail = "c0d3h01@gmail.com";
      };

      # Generate pkgs with custom configurations
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (final: prev: {
            stable = import nixpkgs-stable {
              inherit system;
              config.allowUnfree = true;
            };
          })
        ];
      };
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations.${specialArgs.hostname} = lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          ./hosts/c0d3h01 # User Modules
          inputs.stylix.nixosModules.stylix

          ({ config, specialArgs, ... }: {
            system.stateVersion = "24.11";
            networking.hostName = specialArgs.hostname;
          })

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = specialArgs;
              users.${specialArgs.username} = import ./home;
            };
          }
          nur.modules.nixos.default
        ];
      };
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          pkg-config
          gtk3
        ];
        shellHook = "exec ${pkgs.zsh}/bin/zsh";
      };
      formatter.${system} = pkgs.nixpkgs-fmt;
    };
}
