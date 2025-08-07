{
  lib,
  pkgs,
  userConfig,
  ...
}:

{
  config = lib.mkIf userConfig.devStack.virtualisation {
    programs.virt-manager.enable = true;
    users.users.${userConfig.username}.extraGroups = [
      "libvirtd"
      "kvm"
    ];

    virtualisation = {
      libvirtd = {
        enable = true;
        qemu.package = pkgs.qemu_kvm;
        onBoot = "ignore";
        onShutdown = "shutdown";
      };
    };
  };
}
