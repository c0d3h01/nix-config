{
  inputs,
  config,
  pkgs,
  lib,
  userConfig,
  ...
}:

{
  imports = [
    ../installer
    ../../nixosModules
    ../../secrets
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

  users.mutableUsers = false;

  users.users = {

    root = {
      # Allow the user to log in as root without a password.
      hashedPassword = "";
    };

    ${userConfig.username} = {
      description = userConfig.fullName;
      isNormalUser = true;
      shell = pkgs.zsh;
      ignoreShellProgramCheck = true;
      home = "/home/${userConfig.username}";
      # hashedPasswordFile = "/run/secrets/${userConfig.username}-passwd";
      hashedPassword = "$6$kSA3b9/kB7OH7iC7$vLinn51U1LLTWo1BGIY6JhqKNrzZ7Xj6xOwhbQv4fZRQq99qkZBhqshW/5LjcAJygLH5G2XoK6dfkrwgKycUY0";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICSjL8HGjiSAnLHupMZin095bql7A8+UDfc7t9XCZs8l harshalsawant.dev@gmail.com"
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
  };
}
