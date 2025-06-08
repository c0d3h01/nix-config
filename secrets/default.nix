{
  declarative,
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    inputs.agenix.nixosModules.default
  ];
  age.identityPaths = [
    "/etc/ssh/ssh_host_ed25519_key"
  ];
  environment.systemPackages = with pkgs; [
    inputs.agenix.packages.x86_64-linux.default
    age
  ];
}
