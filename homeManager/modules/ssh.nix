{ config, ... }:

{
  programs.ssh = {
    enable = true;
    hashKnownHosts = true;
    compression = true;

    matchBlocks = {
      "github.com" = {
        user = "git";
        hostname = "github.com";
        identityFile = config.sops.secrets.keys-gh.path;
      };

      "gitlab.com" = {
        user = "git";
        hostname = "gitlab.com";
      };

      "codeberg.org" = {
        user = "git";
        hostname = "codeberg.org";
        identityFile = config.sops.secrets.keys-codeberg.path;
      };
    };
  };

  sops.secrets = {
    keys-gh = { };
    keys-gh-pub = { };
    keys-codeberg = { };
  };
}
