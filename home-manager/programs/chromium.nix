{
  lib,
  pkgs,
  config,
  userConfig,
  ...
}:

let
  inherit (lib) optionals concatStringsSep mkIf;

  # FEATURE FLAGS
  enableFeaturesList = [
    "WebContentsForceDark"
    "UseOzonePlatform"
    "WaylandWindowDecorations"
    "SharedArrayBuffer"
  ];

  disableFeaturesList = [
    "AutofillServerCommunication"
    "MediaDrmPreprovisioning"
    "OptimizationHintsFetching"
  ];

  # COMMAND LINE FLAGS - DEVELOPMENT OPTIMIZED
  # Performance Optimizations
  performanceFlags = [
    # GPU Acceleration
    "--enable-gpu-rasterization"
    "--enable-oop-rasterization"
    "--enable-zero-copy"

    # V8 JavaScript Engine (Development Optimized)
    "--js-flags=--max-old-space-size=2048,--max-semi-space-size=16"
  ];

  # Privacy & Security (Non-Breaking)
  securityFlags = [
    "--no-pings"
    "--no-crash-upload"
    "--disable-breakpad"
  ];

  # Wayland Support (Auto-Fallback)
  waylandFlags = [
    "--ozone-platform-hint=auto"
  ];

  # UI/UX
  aestheticFlags = [
    "--force-dark-mode"
  ];

  # Cache Management (Persistent, Dev-Sized)
  cacheFlags = [
    "--disk-cache-dir=${config.xdg.cacheHome}/google-chrome"
    "--disk-cache-size=524288000" # 500MB for dev assets
  ];

  # Developer Experience Features
  devFlags = [
    # Enable bleeding-edge web APIs
    "--enable-experimental-web-platform-features"

    # Allow localhost HTTPS without certificates
    "--allow-insecure-localhost"

    # Disable XSS auditor (causes false positives in dev)
    "--disable-xss-auditor"

    # Auto-open DevTools for popup windows
    "--auto-open-devtools-for-tabs"
  ];

  # Startup & Misc
  miscFlags = [
    "--no-first-run"
    "--no-default-browser-check"
  ];

  # COMBINED FLAGS
  allFlags =
    performanceFlags
    ++ securityFlags
    ++ waylandFlags
    ++ aestheticFlags
    ++ cacheFlags
    ++ devFlags
    ++ miscFlags
    ++ [
      "--enable-features=${concatStringsSep "," enableFeaturesList}"
      "--disable-features=${concatStringsSep "," disableFeaturesList}"
    ];

  # CHROME WRAPPER
  optimizedChrome = pkgs.symlinkJoin {
    name = "google-chrome-optimized";
    paths = [ pkgs.google-chrome ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/google-chrome-stable \
        --add-flags "${concatStringsSep " " allFlags}"
    '';
  };

in
{
  # PACKAGE INSTALLATION
  home.packages = optionals userConfig.machineConfig.workstation.enable [
    optimizedChrome
  ];

  # DIRECTORY SETUP
  home.activation = mkIf userConfig.machineConfig.workstation.enable {
    # Create cache directory
    createChromeCache = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD mkdir -p ${config.xdg.cacheHome}/google-chrome
    '';
  };

  # DESKTOP ENTRY
  xdg.desktopEntries = mkIf userConfig.machineConfig.workstation.enable {
    google-chrome = {
      name = "Google Chrome";
      genericName = "Web Browser";
      comment = "Development-optimized Chrome";
      exec = "google-chrome-stable %U";
      icon = "google-chrome";
      terminal = false;
      categories = [
        "Network"
        "WebBrowser"
        "Development"
      ];
      mimeType = [
        "text/html"
        "text/xml"
        "application/xhtml+xml"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
      ];
    };
  };

  # Install extensions system-wide
  programs.chromium = mkIf userConfig.machineConfig.workstation.enable {
    enable = true;
    extensions = [
      "fmkadmapgofadopljbjfkapdkoienihi" # React Developer Tools
      "nhdogjmejiglipccpnnnanhbledajbpd" # Vue.js devtools
      "lmhkpmbekcpmknklioeibfkpmmfibljd" # Redux DevTools
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
    ];
  };
}
