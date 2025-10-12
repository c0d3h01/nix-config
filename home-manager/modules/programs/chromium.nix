{
  lib,
  pkgs,
  osConfig,
  userConfig,
  ...
}:
let
  inherit (lib)
    optionals
    concatLists
    concatMapStrings
    enableFeature
    ;

    # Path where you store your icons (update this path if different)
    iconBasePath = "${osConfig.home.homeDirectory}/.local/share/icons/dashboard";

    webApps = [
      { name = "Telegram Web"; url = "https://web.telegram.org/"; icon = "${iconBasePath}/telegram.svg"; }
      { name = "Discord"; url = "https://discord.com/app"; icon = "${iconBasePath}/discord.svg"; }
      { name = "Slack Web"; url = "https://slack.com/signin"; icon = "${iconBasePath}/slack.svg"; }
      { name = "Zoom Web"; url = "https://zoom.us/signin"; icon = "${iconBasePath}/zoom.svg"; }
    ];
in
{
  programs.chromium = lib.mkIf userConfig.machineConfig.workstation.enable {
    enable = true;

    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
      "pihphjfnfjmdbhakhjifipfdgbpenobg" # DocsAfterDark
    ];

    package = pkgs.chromium.override {
      enableWideVine = true;

      # https://github.com/secureblue/hardened-chromium
      # https://github.com/secureblue/secureblue/blob/e500f078efc5748d5033a881bbbcdcd2de95a813/files/system/usr/etc/chromium/chromium.conf.md
      commandLineArgs = concatLists [
        # Aesthetics
        [
          "--force-dark-mode"
          "--gtk-version=4"
        ]

        # Performance
        [
          (enableFeature true "gpu-rasterization")
          (enableFeature true "oop-rasterization")
          (enableFeature true "zero-copy")
          "--ignore-gpu-blocklist"
        ]

        # Wayland
        [
          "--ozone-platform=wayland"
          "--enable-features=UseOzonePlatform"
        ]

        # Etc
        [
          "--disk-cache=$XDG_RUNTIME_DIR/chromium-cache"
          (enableFeature false "reading-from-canvas")
          "--no-first-run"
          "--disable-wake-on-wifi"
          "--disable-breakpad"

          # please stop asking me to be the default browser
          "--no-default-browser-check"

          # I don't need these, thus I disable them
          (enableFeature false "speech-api")
          (enableFeature false "speech-synthesis-api")
        ]

        # Security
        [
          # Use strict extension verification
          "--extension-content-verification=enforce_strict"
          "--extensions-install-verification=enforce_strict"
          # Disable pings
          "--no-pings"
          # Require HTTPS for component updater
          "--component-updater=require_encryption"
          # Disable crash upload
          "--no-crash-upload"
          # don't run things without asking
          "--no-service-autorun"
          # Disable sync
          "--disable-sync"

          (
            "--enable-features="
            + concatMapStrings (x: x + ",") [
              # Enable visited link database partitioning
              "PartitionVisitedLinkDatabase"
              # Enable prefetch privacy changes
              "PrefetchPrivacyChanges"
              # Enable split cache
              "SplitCacheByNetworkIsolationKey"
              "SplitCodeCacheByNetworkIsolationKey"
              # Enable partitioning connections
              "EnableCrossSiteFlagNetworkIsolationKey"
              "HttpCacheKeyingExperimentControlGroup"
              "PartitionConnectionsByNetworkIsolationKey"
              # Enable strict origin isolation
              "StrictOriginIsolation"
              # Enable reduce accept language header
              "ReduceAcceptLanguage"
              # Enable content settings partitioning
              "ContentSettingsPartitioning"
              # allow --force-dark-mode to work
              "WebContentsForceDark"
            ]
          )

          (
            "--disable-features="
            + concatMapStrings (x: x + ",") [
              # Disable autofill
              "AutofillPaymentCardBenefits"
              "AutofillPaymentCvcStorage"
              "AutofillPaymentCardBenefits"
              # Disable third-party cookie deprecation bypasses
              "TpcdHeuristicsGrants"
              "TpcdMetadataGrants"
              # Disable hyperlink auditing
              "EnableHyperlinkAuditing"
              # Disable showing popular sites
              "NTPPopularSitesBakedInContent"
              "UsePopularSitesSuggestions"
              # Disable article suggestions
              "EnableSnippets"
              "ArticlesListVisible"
              "EnableSnippetsByDse"
              # Disable content feed suggestions
              "InterestFeedV2"
              # Disable media DRM preprovisioning
              "MediaDrmPreprovisioning"
              # Disable autofill server communication
              "AutofillServerCommunication"
              # Disable new privacy sandbox features
              "PrivacySandboxSettings4"
              "BrowsingTopics"
              "BrowsingTopicsDocumentAPI"
              "BrowsingTopicsParameters"
              # Disable translate button
              "AdaptiveButtonInTopToolbarTranslate"
              # Disable detailed language settings
              "DetailedLanguageSettings"
              # Disable fetching optimization guides
              "OptimizationHintsFetching"
              # Partition third-party storage
              "DisableThirdPartyStoragePartitioningDeprecationTrial2"

              # Disable media engagement
              "PreloadMediaEngagementData"
              "MediaEngagementBypassAutoplayPolicies"
            ]
          )
        ]
      ];
    };
  };

  # Generate launchers for web apps
  home.packages = optionals userConfig.machineConfig.workstation.enable (
    map
      (app: pkgs.makeDesktopItem {
        name = lib.strings.escapeName app.name;
        exec = "${pkgs.chromium}/bin/chromium --app='${app.url}'";
        icon = app.icon;
        comment = "Web App for ${app.name}";
        desktopName = app.name;
        categories = [ "Network" ];
      })
      webApps
  );
}