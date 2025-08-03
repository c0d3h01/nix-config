{
  config,
  lib,
  pkgs,
  userConfig,
  ...
}:

let
  isNvidia = userConfig.machine.gpuType == "nvidia";
  isIntel = userConfig.machine.gpuType == "intel";
  isAmd = userConfig.machine.gpuType == "amd";
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
      ++ lib.optionals isIntel [
        intel-media-driver
        intel-vaapi-driver
        libva-vdpau-driver
      ]

      # AMD-specific packages
      ++ lib.optionals isAmd [
        amdvlk # AMD Vulkan driver
        rocmPackages.clr # AMD OpenCL support
        mesa
      ]

      # NVIDIA-specific packages
      ++ lib.optionals isNvidia [
        libva-vdpau-driver
        nvidia-vaapi-driver
        libvdpau-va-gl
      ];

    extraPackages32 =
      with pkgs.pkgsi686Linux;
      [
        mesa
        libva
        libvdpau
        vulkan-loader
      ]

      ++ lib.optionals isNvidia [
        nvidia-vaapi-driver
      ]

      ++ lib.optionals isIntel [
        intel-media-driver
        libva-vdpau-driver
        intel-vaapi-driver
      ];
  };

  # NVIDIA configuration
  hardware.nvidia = lib.mkIf isNvidia {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = lib.mkDefault false; # Set based on GPU generation
    nvidiaSettings = true;
  };

  boot.kernelParams = lib.mkMerge [
    # Intel GPU
    (lib.mkIf isIntel [
      "i915.enable_fbc=1"
      "i915.enable_psr=1"
    ])

    # AMD GPU
    (lib.mkIf isAmd [
      "amdgpu.si_support=1"
      "amdgpu.cik_support=1"
    ])

    # NVIDIA DRM kernel mode setting
    (lib.mkIf isNvidia [
      "nvidia-drm.modeset=1"
    ])
  ];

  # Blacklist conflicting drivers
  boot.blacklistedKernelModules = lib.mkIf isNvidia [ "nouveau" ];

  # Environment variables for optimal GPU performance
  environment.sessionVariables = {
    # VA-API driver selection
    LIBVA_DRIVER_NAME =
      if isIntel then
        "iHD"
      else if isAmd then
        "radeonsi"
      else if isNvidia then
        "vdpau"
      else
        "";

    # VDPAU driver selection
    VDPAU_DRIVER =
      if isAmd then
        "radeonsi"
      else if isNvidia then
        "nvidia"
      else
        "";
  }
  // lib.optionalAttrs config.hardware.nvidia.prime.offload.enable {
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
    ++ lib.optionals isAmd [
      nvtopPackages.amd
    ]
    ++ lib.optionals isIntel [
      nvtopPackages.intel
    ]
    ++ lib.optionals isNvidia [
      nvtopPackages.nvidia
    ];
}
