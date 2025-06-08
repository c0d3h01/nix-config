{
  description = "NixOS Flake: workspace";

  inputs = {
    # Nixpkgs channels
    nixpkgs.url = "git+https://github.com/nixos/nixpkgs?shallow=1&ref=nixos-unstable-small";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    systems.url = "github:nix-systems/default";
    flake-utils.inputs.systems.follows = "systems";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-stable";

    # Host-specific modules
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs-stable";
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs-stable";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    pre-commit-hooks.inputs.nixpkgs.follows = "nixpkgs";
    ghostty.url = "github:ghostty-org/ghostty";
    ghostty.inputs.nixpkgs.follows = "nixpkgs-stable";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    devenv.url = "github:cachix/devenv";
    devenv.inputs.nixpkgs.follows = "nixpkgs-stable";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    vscode-server.inputs.nixpkgs.follows = "nixpkgs";
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-stable,
      flake-utils,
      home-manager,
      ...
    }:
    let
      declarative = {
        hostname = "devbox";
        username = "c0d3h01";
        fullName = "Harshal Sawant";
      };

      allSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs allSystems;

      overlays = [
        (final: prev: {
          stable = import nixpkgs-stable {
            system = final.system or "x86_64-linux";
            config.allowUnfree = true;
          };
          helix = inputs.helix.packages.${final.system or "x86_64-linux"}.helix;
          devenv = inputs.devenv.packages.${final.system or "x86_64-linux"}.devenv;
        })
      ];

      nixpkgsConfig = {
        config = {
          allowUnfree = true;
          allowBroken = false;
          allowUnsupportedSystem = false;
        };
        overlays = overlays;
      };

      machineModule = name: ./machines/${name};
      homeModule = ./home-manager/home.nix;

      # Modular devshells import
      devShellModules = {
        python = ./devshells/python.nix;
        rust = ./devshells/rust.nix;
        node = ./devshells/node.nix;
        go = ./devshells/go.nix;
        java = ./devshells/java.nix;
      };
    in

    flake-utils.lib.eachSystem allSystems (
      system:
      let
        pkgs = import nixpkgs { inherit system; } // nixpkgsConfig;
        pkgsStable = import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };
      in
      {
        formatter = pkgs.nixfmt-tree;

        checks.pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            alejandra.enable = true;
            statix.enable = true;
            deadnix.enable = true;
          };
        };

        # Devshells for languages
        devShells = builtins.mapAttrs (name: file: import file { inherit pkgs; }) devShellModules;

        homeConfigurations."${declarative.username}@${declarative.hostname}" =
          home-manager.lib.homeManagerConfiguration
            {
              pkgs = pkgs;
              extraSpecialArgs = {
                inherit inputs self declarative;
                pkgsStable = pkgsStable;
                pkgsUnstable = pkgs;
              };
              modules = [ homeModule ];
            };
      }
    )
    // {
      nixosConfigurations.${declarative.hostname} = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs self declarative;
          pkgsStable = import nixpkgs-stable {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          pkgsUnstable = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
        };
        modules = [
          (machineModule declarative.username)
          inputs.disko.nixosModules.disko
          (
            { config, ... }:
            {
              nixpkgs = nixpkgsConfig;
            }
          )
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs self declarative;
                pkgsStable = import nixpkgs-stable {
                  system = "x86_64-linux";
                  config.allowUnfree = true;
                };
                pkgsUnstable = import nixpkgs {
                  system = "x86_64-linux";
                  config.allowUnfree = true;
                };
              };
              users.${declarative.username} = {
                imports = [ homeModule ];
              };
            };
          }
        ];
      };
    };
}
