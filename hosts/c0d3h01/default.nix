{ config
, pkgs
, specialArgs
, ...
}:
{
  imports = [
    ../../modules
    ../../secrets
    # Hardware configuration
    ./hardware-configuration.nix
  ];

  time.timeZone = "Asia/Kolkata";
  i18n = {
    defaultLocale = "en_IN";
    extraLocaleSettings = {
      LC_ADDRESS = "en_IN";
      LC_IDENTIFICATION = "en_IN";
      LC_MEASUREMENT = "en_IN";
      LC_MONETARY = "en_IN";
      LC_NAME = "en_IN";
      LC_NUMERIC = "en_IN";
      LC_PAPER = "en_IN";
      LC_TELEPHONE = "en_IN";
      LC_TIME = "en_IN";
    };
  };

  users.users.${specialArgs.username} = {
    description = "Harshal Sawant";
    isNormalUser = true;
    home = "/home/${specialArgs.username}";
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "video"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMeUqmD36Sp53CW96W3yCumTY8nt4xN1UAugJGm1AelM c0d3h01@gmail.com"
    ];
  };
}
