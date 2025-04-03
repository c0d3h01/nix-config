{
  description = "NixOS Dotfiles c0d3h01";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      # ========== Configuration ==========
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      defaultSystem = "x86_64-linux";

      userConfig = {
        username = "c0d3h01";
        fullName = "Harshal Sawant";
        email = "c0d3h01@gmail.com";
        hostname = "NixOS";
        stateVersion = "24.11";
      };

      # ========== Helper Functions ==========
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      mkPkgs = system: import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (final: prev: {
            unstable = import inputs.nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          })
          inputs.nur.overlays.default
        ];
      };

      mkSpecialArgs = system: {
        inherit inputs system;
        user = userConfig;
        pkgs = mkPkgs system;
      };

      # ========== NixOS Configuration ==========
      mkNixOSConfiguration = { system ? defaultSystem, hostname ? userConfig.hostname }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = mkSpecialArgs system;

          modules = [
            # Host-specific configuration
            ./hosts/${userConfig.username}

            # Home Manager integration
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = mkSpecialArgs system;
                users.${userConfig.username} = {
                  imports = [ ./home ];
                  home.stateVersion = userConfig.stateVersion;
                };
              };
            }
          ];
        };

    in
    {
      # ========== Outputs ==========
      nixosConfigurations.${userConfig.hostname} = mkNixOSConfiguration { };

      devShells = forAllSystems (system:
        let
          pkgs = mkPkgs system;
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              pkg-config
              gtk3
            ];
            shellHook = "exec ${pkgs.zsh}/bin/zsh";
          };

          ci = pkgs.mkShell {
            packages = with pkgs; [
              nixpkgs-fmt
              statix
              deadnix
            ];
          };
        });

      formatter = forAllSystems (system: (mkPkgs system).nixpkgs-fmt);

      checks = forAllSystems (system:
        inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            nixpkgs-fmt.enable = true;
            statix.enable = true;
            deadnix.enable = true;
          };
        });
    };
}
