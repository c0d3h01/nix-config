{
  lib,
  pkgs,
  ...
}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = false;

    extraPackages = with pkgs; [
      rocmPackages.clr.icd # OpenCL for parallel compute
    ];
  };

  services.xserver.videoDrivers = ["amdgpu"];
  hardware.amdgpu.opencl.enable = true;
}
