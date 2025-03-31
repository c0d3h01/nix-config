{ config
, pkgs
, ...
}:
{
  boot = {
    tmp.cleanOnBoot = true;
    consoleLogLevel = 1;
    initrd = {
      verbose = false;
    };
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
    kernelParams = [
      "preempt=full"
      "mitigations=off"
      "udev.log_level=3"
    ];
    kernel.sysctl = {
      "net.ipv4.tcp_congestion_control" = "bbr";
    };
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 4;
        consoleMode = "max";
        editor = false;
      };
      # grub = {
      #   enable = true;
      #   device = "nodev";
      #   efiSupport = true;
      #   useOSProber = false;
      # };
    };
  };
}
