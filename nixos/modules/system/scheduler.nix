{
  pkgs,
  userConfig,
  ...
}: {
  services.scx = {
    enable = userConfig.workstation;
    scheduler = "scx_bpfland";
    package = pkgs.scx.rustscheds;
  };
}
