# https://github.com/nix-community/home-manager/issues/2942

{
  allowUnfree = true;
  allowUnfreePredicate = true;
  #allowUnsupportedSystem = true;
  oraclejdk.accept_license = true;
  android_sdk.accept_license = true;
}
