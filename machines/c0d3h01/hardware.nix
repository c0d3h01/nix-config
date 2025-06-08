{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  zramSwap = {
    enable = true;
    priority = 100;
    algorithm = "zstd";
    memoryPercent = 180;
  };

  services.fstrim = {
    enable = true;
    interval = "daily";
  };

  environment.systemPackages = with pkgs; [
    mesa-demos
  ];

  boot.loader = {
    grub = lib.mkDefault {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev"; # For UEFI
    };
    systemd-boot.enable = false;
    efi.canTouchEfiVariables = false;
    timeout = 5;
  };

  boot = {
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];

    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "quiet"
      "nowatchdog"
      "loglevel=3"
      "mitigations=off"
      "nvme.noacpi=1"
    ];

    kernel.sysctl = {
      # --- Memory Management ---
      "vm.swappiness" = 15; # Prefer RAM, use swap as last resort
      "vm.dirty_ratio" = 10; # Percent system memory before writeback
      "vm.dirty_background_ratio" = 5; # Start background writeback at 5%
      "vm.vfs_cache_pressure" = 50; # Keep inode/dentry cache longer
      "vm.page-cluster" = 0; # More efficient swap I/O
      "vm.compaction_proactiveness" = 50; # Improve large allocation performance

      # --- CPU Scheduler ---
      "kernel.sched_migration_cost_ns" = 5000000; # Reduce task migration thrash
      "kernel.sched_latency_ns" = 12000000; # Lower latency for interactive workloads
      "kernel.sched_min_granularity_ns" = 1500000;
      "kernel.sched_wakeup_granularity_ns" = 2000000;

      # --- Network Tweaks ---
      "net.core.rmem_max" = 16777216;
      "net.core.wmem_max" = 16777216;
      "net.ipv4.tcp_rmem" = "4096 87380 16777216";
      "net.ipv4.tcp_wmem" = "4096 16384 16777216";
      "net.ipv4.tcp_congestion_control" = "bbr"; # Use BBR if available for better WiFi/latency

      # --- Filesystem (BTRFS) ---
      "vm.dirty_expire_centisecs" = 1500; # Writeback after 15s (BTRFS safe)
      "vm.dirty_writeback_centisecs" = 500; # Background writeback interval (5s)

      # --- Misc ---
      "fs.inotify.max_user_watches" = 1048576; # Avoid Electron/IDE file watch issues
      "fs.inotify.max_user_instances" = 8192;
      "fs.file-max" = 2097152; # Allow more open files (for dev/desktops)
    };

    initrd = {
      verbose = false;
      kernelModules = [ ];
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usb_storage"
        "sd_mod"
      ];
    };
  };

  networking.useDHCP = lib.mkDefault true;
  networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;
  networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
