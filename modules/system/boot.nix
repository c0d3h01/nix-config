{ pkgs
, ...
}: {

  boot = {
    tmp.cleanOnBoot = true;
    consoleLogLevel = 3;
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;

    initrd = {
      verbose = false;
    };

    kernelParams = [
      "quiet"
      "preempt=full"
      "mitigations=off"
      "udev.log_level=3"
    ];

    kernel.sysctl = {

      # Network optimizations settings
      "net.ipv4.tcp_congestion_control" = "bbr2";

      # buffer limits: 32M max, 16M default
      "net.core.rmem_max" = 33554432;
      "net.core.wmem_max" = 33554432;
      "net.core.rmem_default" = 16777216;
      "net.core.wmem_default" = 16777216;
      "net.core.optmem_max" = 40960;
      # cloudflare uses this for balancing latency and throughput
      # https://blog.cloudflare.com/the-story-of-one-latency-spike/
      "net.ipv4.tcp_mem" = "786432 1048576 26777216";
      "net.ipv4.tcp_rmem" = "4096 1048576 2097152";
      "net.ipv4.tcp_wmem" = "4096 65536 16777216";

      # http://www.nateware.com/linux-network-tuning-for-2013.html
      "net.core.netdev_max_backlog" = 100000;
      "net.core.netdev_budget" = 100000;
      "net.core.netdev_budget_usecs" = 100000;

      "net.ipv4.tcp_max_syn_backlog" = 30000;
      "net.ipv4.tcp_max_tw_buckets" = 2000000;
      "net.ipv4.tcp_tw_reuse" = 1;
      "net.ipv4.tcp_fin_timeout" = 10;

      "net.ipv4.udp_rmem_min" = 8192;
      "net.ipv4.udp_wmem_min" = 8192;
    };

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 4;
        consoleMode = "auto";
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
