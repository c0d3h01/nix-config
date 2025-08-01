{
  nixgl,
  ...
}:
{
  # NixGL configuration for GPU support
  nixGL = {
    vulkan.enable = true;
    inherit (nixgl) packages;
    defaultWrapper = "mesa";
    offloadWrapper = "mesa";
    installScripts = [ "mesa" ];
  };
}
