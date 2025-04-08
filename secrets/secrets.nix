let
  keys = import ./keys.nix;
in
with keys;
{
  # SSH Key
  "ssh-private-key" = {
    file = ./ssh-private-key.age;
    owner = "c0d3h01";
    group = "users";
    mode = "600";
    path = "/home/c0d3h01/.ssh/id_ed25519";
    publicKeys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPMHEDTYxp5o3ZLpEg4fWjXZ/MctVco8R9qYVfE0tIn+ c0d3h01@gmail.com" ];
  };
}
