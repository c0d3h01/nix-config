let
  userPublicKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG5qPWYOZSxl3Fnsiu3fBCTxQuwGrigSoqHAoMpLGmAC harshalsawant.dev@gmail.com"
  ];

  systemPublicKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFRE0JplI8hxY68EhpXnfU6otlNt4lAV38BRo9t5heC+ root@NixOS"
  ];
in
{
  "ssh.age".publicKeys = userPublicKeys ++ systemPublicKeys;
  "userPassword.age".publicKeys = userPublicKeys ++ systemPublicKeys;
  "sshPublicKeys.age".publicKeys = userPublicKeys ++ systemPublicKeys;
  "element.age".publicKeys = userPublicKeys ++ systemPublicKeys;
}
