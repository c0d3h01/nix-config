{
  config,
  pkgs,
  lib,
  ...
}:

let
  androidenv = pkgs.androidenv.override { licenseAccepted = true; };

  androidSdk =
    (androidenv.composeAndroidPackages {
      cmdLineToolsVersion = "8.0";
      platformToolsVersion = "35.0.2";
      buildToolsVersions = [ "30.0.3" ];
      platformVersions = [ "30" ];
      includeEmulator = false;
      includeSources = false;
      includeSystemImages = false;
      includeNDK = true;
      ndkVersions = [ "22.0.7026061" ];
      extraLicenses = [ "android-sdk-license" ];
    }).androidsdk;

  sdkRoot = "${androidSdk}/libexec/android-sdk";

in
{
  options = {
    myModules.androidTools = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Android tools installation";
    };
  };

  config = lib.mkIf config.myModules.androidTools {
    environment.systemPackages = with pkgs; [
      androidSdk
    ];

    environment.variables = {
      ANDROID_HOME = sdkRoot;
      ANDROID_SDK_ROOT = sdkRoot;
      ANDROID_NDK_ROOT = "${sdkRoot}/ndk/22.0.7026061";
      CHROME_EXECUTABLE = "${pkgs.firefox-esr}/bin/firefox-esr";
      JAVA_HOME = "${pkgs.openjdk}/lib/openjdk";
    };

    environment.shellInit = ''
      export PATH="$ANDROID_NDK_ROOT:$PATH"
      export PATH="$ANDROID_SDK_ROOT/platform-tools:$PATH"
      export PATH="$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$PATH"
      export PATH="$ANDROID_SDK_ROOT/build-tools/30.0.3:$PATH"
    '';
  };
}
