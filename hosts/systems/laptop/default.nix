{
  lib,
  userConfig,
  ...
}: let
  isUsr = userConfig.username == "c0d3h01";

  # Define your keys here to reuse them
  myKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDgTxUEL0BNaKsL0FXEBY9PJRO0itKILY2Z5Buxzb79N c0d3h01"
  ];
in {
  imports = [
    ../../disko/hardware0x0.nix
  ];

  users.users = lib.mkIf isUsr {
    root = {
      hashedPassword = "";
      # Use the variable defined above
      openssh.authorizedKeys.keys = myKeys;
    };

    c0d3h01 = {
      home = "/home/c0d3h01";
      hashedPassword = "$y$j9T$jbMpDi1jashn36Vczb8jO/$E8M0edjvWOZg24Su5bFWaQ5tHcPkwyQ8HdzkAMx0km7";
      # Use the variable defined above
      openssh.authorizedKeys.keys = myKeys;
    };
  };
}
