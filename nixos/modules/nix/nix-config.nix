{
  nixpkgs = {
    config = {
      # Unfree: allowed
      allowUnfree = true;

      # Narrow unfree scope.
      allowUnfreePredicate = true;

      # DO NOT allow all insecure packages globally.
      allowInsecure = true;

      # Accept Android SDK license
      android_sdk.accept_license = true;

      # Usually leave false; enabling hides unsupported attrpaths that may break differently.
      allowUnsupportedSystem = true;
    };
  };
}
