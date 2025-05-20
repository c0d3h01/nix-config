{
  virtualisation.libvirtd.enable = true;
  users.users.c0d3h01.extraGroups = [ "libvirtd" ];
  networking.firewall.checkReversePath = false;
  programs.virt-manager.enable = true;
}
