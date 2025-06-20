{
  config,
  pkgs,
  lib,
  declarative,
  ...
}:

{
  imports = [
    ../installer/disko-config.nix
    ./hardware.nix
    ../../nixosModules
    ../../secrets
    ../../sops
  ];

  documentation.enable = false;
  documentation.nixos.enable = lib.mkForce false;
  documentation.info.enable = false;
  documentation.doc.enable = false;

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

  # Configure keymap in x11
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
    videoDrivers = [ "amdgpu" ];
  };

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
        if (action.id.indexOf("org.freedesktop.udisks2.filesystem-mount") == 0 &&
            subject.isInGroup("users")) {
            return polkit.Result.YES;
        }
    });
  '';

  users.users.${declarative.username} = {
    description = declarative.fullName;
    isNormalUser = true;
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    home = "/home/${declarative.username}";
    hashedPasswordFile = config.age.secrets.ssh-key.path;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO8va6PxchHjK67XVlCqf8R2Hy7OeSji1Ve6PscBhhY0 harshalsawant.dev@gmail.com"
    ];
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "video"
      "adbusers"
      "wireshark"
      "usbmon"
    ];
  };
}
