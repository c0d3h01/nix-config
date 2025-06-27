{
  inputs,
  config,
  userConfig,
  ...
}:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    age = {
      keyFile = "/etc/sops/sops-secrets-key.txt";
      sshKeyPaths = [
        "/etc/ssh/ssh_host_ed25519_key"
      ];
    };

    secrets = {
      "c0d3h01-passwd" = {
        sopsFile = ./c0d3h01/c0d3h01-passwd.enc;
        path = "/run/secrets/c0d3h01-passwd";
        format = "binary";
      };
      "passwd" = {
        sopsFile = ./c0d3h01/passwd.enc;
        path = "/run/secrets/passwd";
        format = "binary";
      };
      "ssh-host" = {
        sopsFile = ./c0d3h01/ssh-host.enc;
        path = "/run/secrets/ssh-host";
        format = "binary";
      };
      "element" = {
        sopsFile = ./c0d3h01/element.enc;
        path = "/run/secrets/element";
        format = "binary";
      };
    };
  };
}
