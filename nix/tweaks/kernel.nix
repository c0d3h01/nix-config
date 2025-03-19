{ ... }:

{
  boot.kernelParams = [
    # CPU Performance
    "processor.max_cstate=2"          # Limit CPU idle states to reduce latency
    "intel_idle.max_cstate=2"        # For Intel CPUs (not applicable here, but included for completeness)
    "amd_iommu=on"                   # Enable AMD IOMMU for better I/O performance
    "idle=nomwait"                   # Disable MWAIT for CPU idle states (improves responsiveness)
    "mitigations=off"                # Disable CPU vulnerability mitigations for better performance
    "nohz_full=1-7"                  # Enable nohz_full for tickless operation on all cores (reduce latency)
    "rcu_nocbs=1-7"                  # Offload RCU callbacks from CPUs for better performance
    "transparent_hugepage=always"    # Enable transparent huge pages for better memory management

    # GPU Performance (AMD Vega)
    "amdgpu.ppfeaturemask=0xffffffff" # Enable all power features for AMD GPU
    "amdgpu.dc=1"                    # Enable Display Core (DC) for better GPU performance
    "amdgpu.sched_jobs=32"           # Increase GPU scheduler jobs for better multitasking
    "amdgpu.vm_fragment_size=9"      # Optimize GPU memory fragmentation

    # I/O Performance
    "elevator=noop"                  # Use noop I/O scheduler for SSDs (better performance)
    "scsi_mod.use_blk_mq=1"          # Enable multi-queue for SCSI devices
    "nvme_core.io_timeout=4294967295" # Increase NVMe timeout for better reliability
    "nvme_core.max_retries=10"       # Increase NVMe retry attempts

    # Power Management (Performance-Oriented)
    "pcie_aspm=off"                  # Disable ASPM for better PCIe performance
    "pcie_aspm.policy=performance"   # Set PCIe ASPM policy to performance
    "acpi_osi=Linux"                 # Ensure proper ACPI support
    "acpi_backlight=vendor"          # Use vendor-specific backlight control

    # Network Performance
    "net.core.netdev_max_backlog=16384" # Increase network backlog for better throughput
    "net.core.somaxconn=4096"        # Increase socket connection limit
    "net.ipv4.tcp_fastopen=3"       # Enable TCP Fast Open for faster connections

    # Memory Management
    "vm.swappiness=10"               # Reduce swap usage (prioritize RAM)
    "vm.dirty_ratio=10"              # Write dirty pages to disk sooner
    "vm.dirty_background_ratio=5"    # Background writeback threshold
    "vm.vfs_cache_pressure=50"       # Balance between reclaiming inode/dentry caches
  ];
}