{ ... }:

{
  # -*- Enable printing -*-
  services = {
    printing.enable = true;
    avahi.enable = true;
    avahi.openFirewall = true;
  };
  networking.firewall.allowedTCPPorts = [ 631 ];
}
