{
  userConfig,
  lib,
  pkgs,
  ...
}:
let
  inherit (userConfig.machine) gpuType;

  # Determine acceleration type based on GPU
  acceleration =
    if gpuType == "nvidia" then
      "cuda"
    else if gpuType == "amd" then
      "rocm"
    else if gpuType == "intel" then
      "opencl"
    else
      null; # Fallback for unknown GPU types
in
{
  # AI and ML services
  services.ollama = {
    enable = true;

    # Set appropriate acceleration based on GPU type
    inherit acceleration;

    # Optimize settings based on GPU type
    environmentVariables = lib.mkMerge [
      # Common settings
      {
        OLLAMA_HOST = "127.0.0.1:11434";
      }

      # NVIDIA-specific optimizations
      (lib.mkIf (gpuType == "nvidia") {
        OLLAMA_GPU_OVERHEAD = "0";
        OLLAMA_FLASH_ATTENTION = "1";
      })

      # AMD ROCm-specific optimizations
      (lib.mkIf (gpuType == "amd") {
        OLLAMA_GPU_OVERHEAD = "0";
        ROC_ENABLE_PRE_VEGA = "1";
      })

      # Intel GPU optimizations
      (lib.mkIf (gpuType == "intel") {
        OLLAMA_GPU_OVERHEAD = "0";
      })
    ];

    # Set models directory
    models = "/var/lib/ollama/models";
  };
}
