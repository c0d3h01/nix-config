{ config
, agenix
, specialArgs
, system
, ... 
}:

{
  age.identityPaths = [ "/home/${specialArgs.username}/dotfiles/secrets/keys/default.key" ];
  imports = [ agenix.nixosModules.default ];
  environment.systemPackages = [ agenix.packages.${system}.default ];
  age.secrets = { };
}
