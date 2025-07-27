{
  config,
  lib,
  pkgs,
  userConfig,
  ...
}:

let
  cfg = userConfig.machine;
  isNvidiaSystem = lib.elem cfg.gpuType [
    "nvidia"
    "hybrid-intel"
    "hybrid-amd"
  ];
  isHybridSystem = lib.elem cfg.gpuType [
    "hybrid-intel"
    "hybrid-amd"
  ];
  isIntelSystem = lib.elem cfg.gpuType [
    "intel"
    "hybrid-intel"
  ];
  isAmdSystem = lib.elem cfg.gpuType [
    "amd"
    "hybrid-amd"
  ];
in
{
  # Graphics acceleration
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages =
      with pkgs;
      # Common packages for all GPUs
      [
        mesa
        libva
        libvdpau
        vulkan-loader
      ]

      # Intel-specific packages
      ++ lib.optionals isIntelSystem [
        intel-media-driver
        intel-vaapi-driver
      ]

      # AMD-specific packages
      ++ lib.optionals isAmdSystem [
        amdvlk # AMD Vulkan driver
        rocmPackages.clr # AMD OpenCL support
        mesa
      ]

      # NVIDIA-specific packages
      ++ lib.optionals isNvidiaSystem [
        libva-vdpau-driver
      ];

    extraPackages32 =
      with pkgs.pkgsi686Linux;
      [
        mesa
        libva
        libvdpau
        vulkan-loader
      ]
      ++ lib.optionals isIntelSystem [
        intel-media-driver
        intel-vaapi-driver
      ];
  };

  # NVIDIA configuration
  hardware.nvidia = lib.mkIf isNvidiaSystem {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = lib.mkDefault false; # Set based on GPU generation
    nvidiaSettings = true;

    # PRIME configuration for hybrid systems
    prime = lib.mkIf isHybridSystem {
      offload = {
        enable = lib.mkDefault true; # Better for laptops
        enableOffloadCmd = lib.mkDefault true;
      };
      sync.enable = lib.mkDefault false;

      # Bus IDs - these should be configured per machine
      # Find with: lspci | grep -E "(VGA|3D)"
      nvidiaBusId = lib.mkDefault "PCI:1:0:0";
      intelBusId = lib.mkIf (cfg.gpuType == "hybrid-intel") (lib.mkDefault "PCI:0:2:0");
      amdgpuBusId = lib.mkIf (cfg.gpuType == "hybrid-amd") (lib.mkDefault "PCI:6:0:0");
    };
  };

  # Merge kernel parameters properly to avoid conflicts
  boot.kernelParams = lib.mkMerge [
    # Intel GPU optimizations
    (lib.mkIf isIntelSystem [
      "i915.enable_fbc=1"
      "i915.enable_psr=1"
    ])

    # AMD GPU optimizations
    (lib.mkIf isAmdSystem [
      "amdgpu.si_support=1"
      "amdgpu.cik_support=1"
      "radeon.si_support=0"
      "radeon.cik_support=0"
    ])

    # NVIDIA DRM kernel mode setting
    (lib.mkIf isNvidiaSystem [
      "nvidia-drm.modeset=1"
    ])
  ];

  # Blacklist conflicting drivers
  boot.blacklistedKernelModules = lib.mkIf isNvidiaSystem [ "nouveau" ];

  # Environment variables for optimal GPU performance
  environment.sessionVariables = {
    # VA-API driver selection
    LIBVA_DRIVER_NAME =
      if isIntelSystem then
        "iHD"
      else if isAmdSystem then
        "radeonsi"
      else if isNvidiaSystem then
        "vdpau"
      else
        "auto";

    # VDPAU driver selection
    VDPAU_DRIVER =
      if isAmdSystem then
        "radeonsi"
      else if isNvidiaSystem then
        "nvidia"
      else
        "auto";
  }
  // lib.optionalAttrs (isHybridSystem && config.hardware.nvidia.prime.offload.enable) {
    # PRIME offload variables (applied when using nvidia-offload script)
    __NV_PRIME_RENDER_OFFLOAD = "1";
    __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __VK_LAYER_NV_optimus = "NVIDIA_only";
  };

  # Essential GPU utilities
  environment.systemPackages =
    with pkgs;
    [
      # Common GPU tools
      glxinfo # OpenGL information
      vulkan-tools # Vulkan information
      libva-utils # VA-API information
      vdpauinfo # VDPAU information

    ]
    ++ lib.optionals isAmdSystem [
      nvtopPackages.amd
    ]
    ++ lib.optionals isIntelSystem [
      nvtopPackages.intel
    ]
    ++ lib.optionals isNvidiaSystem [
      nvtopPackages.nvidia
    ]
    ++ lib.optionals isHybridSystem [
      # NVIDIA offload script for hybrid systems
      (pkgs.writeShellScriptBin "nvidia-offload" ''
        export __NV_PRIME_RENDER_OFFLOAD=1
        export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
        export __GLX_VENDOR_LIBRARY_NAME=nvidia
        export __VK_LAYER_NV_optimus=NVIDIA_only
        exec "$@"
      '')
    ];
}
