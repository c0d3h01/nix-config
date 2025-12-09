{
  userConfig,
  lib,
  pkgs,
  ...
}: let
  gpuConfigs = {
    nvidia = {
      acceleration = "cuda";
      envVars = {
        OLLAMA_GPU_OVERHEAD = "0";
        OLLAMA_FLASH_ATTENTION = "1";
        CUDA_VISIBLE_DEVICES = "0";
        OLLAMA_NUM_PARALLEL = "4";
      };
    };
    amd = {
      acceleration = "rocm";
      envVars = {
        OLLAMA_GPU_OVERHEAD = "0";
        ROC_ENABLE_PRE_VEGA = "1";
        HIP_VISIBLE_DEVICES = "0";
        OLLAMA_NUM_PARALLEL = "2";
      };
    };
    intel = {
      acceleration = "vulkan";
      envVars = {
        OLLAMA_GPU_OVERHEAD = "0";
        OLLAMA_NUM_PARALLEL = "2";
      };
    };
    cpu = {
      acceleration = "cpu";
      envVars = {
        OLLAMA_NUM_PARALLEL = "1";
      };
    };
  };
  config = gpuConfigs.${userConfig.machineConfig.gpuType};
  pkgName =
    if config.acceleration == "cpu"
    then "ollama"
    else "ollama-${config.acceleration}";
in {
  services.ollama = {
    enable = true;
    package = pkgs.lib.getAttr pkgName pkgs;
    openFirewall = true;
    environmentVariables = config.envVars;
    loadModels = [
      "qwen2.5-coder:1.5b"
    ];
  };
}
