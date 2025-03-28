{
  description = "Home Manager configuration of c0d3h01";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      username = "c0d3h01";
      hostname = "NixOS";
      useremail = "c0d3h01@gmail.com";

      specialArgs = {
        inherit username hostname useremail;
      };
    in
    {
      homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = specialArgs;
        modules = [
          ./home.nix
          ({ config, ... }: {
            nixpkgs.config.allowUnfree = true;
          })
        ];
      };
    };
}
