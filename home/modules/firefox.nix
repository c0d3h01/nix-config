{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.modules.firefox;
in
{
  options.modules.firefox = { enable = mkEnableOption "firefox"; };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;

      # Balance privacy and functionality
      profiles.c0d3h01 = {
        # Essential extensions
        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          # privacy-badger  
          # darkreader
          # bitwarden # password manager
        ];

        settings = {
          # Enable screenshot functionality
          "extensions.screenshots.disabled" = false;
          "screenshots.browser.component.enabled" = true;
          
          # Enable context menu for screenshots
          "screenshots.browser.action.disabled" = false;
          
          # Keyboard shortcut
          "devtools.screenshot.clipboard.enabled" = true;
          "devtools.screenshot.audio.enabled" = true;
          
          # Basic privacy settings - less aggressive
          "browser.send_pings" = false;
          "browser.urlbar.speculativeConnect.enabled" = true;
          "dom.event.clipboardevents.enabled" = true;
          "media.navigator.enabled" = true;
          "network.cookie.cookieBehavior" = 3;
          "network.http.referer.XOriginPolicy" = 1;
          "network.http.referer.XOriginTrimmingPolicy" = 2;
          "beacon.enabled" = true;
          "browser.safebrowsing.downloads.remote.enabled" = true;
          "network.IDN_show_punycode" = true;
          "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
          "app.shield.optoutstudies.enabled" = false;
          "dom.security.https_only_mode_ever_enabled" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "browser.toolbars.bookmarks.visibility" = "always";
          "geo.enabled" = false;

          # Balanced telemetry approach
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.ping-centre.telemetry" = false;
          "browser.tabs.crashReporting.sendReport" = true;
          "devtools.onboarding.telemetry.logged" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.server" = "";

          # Pocket settings (less restrictive)
          "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "extensions.pocket.enabled" = false;

          # Enable prefetching for better performance
          "network.dns.disablePrefetch" = false;
          "network.prefetch-next" = true;

          # PDF settings
          "pdfjs.enableScripting" = true;

          # SSL settings
          "security.ssl.require_safe_negotiation" = true;

          # Usability improvements
          "identity.fxaccounts.enabled" = true;
          "browser.search.suggest.enabled" = true;
          "browser.urlbar.shortcuts.bookmarks" = true;
          "browser.urlbar.suggest.bookmark" = true;
          "browser.urlbar.shortcuts.history" = true;
          "browser.urlbar.shortcuts.tabs" = true;
          "browser.urlbar.suggest.engines" = true; 
          "browser.urlbar.suggest.history" = true;
          "browser.urlbar.suggest.openpage" = true;
          "browser.urlbar.suggest.topsites" = true;
          "browser.uidensity" = 1;
          "media.autoplay.enabled" = false;
          "toolkit.zoomManager.zoomValues" = ".8,.90,.95,1,1.1,1.2,1.5,2.0";
          "privacy.firstparty.isolate" = false;
          "network.http.sendRefererHeader" = 2;
          
          # Performance improvements
          "browser.cache.disk.enable" = true;
          "browser.cache.memory.enable" = true;
          "browser.cache.memory.capacity" = 524288;
          "browser.sessionstore.interval" = 60000;
          
          # Media and DRM (needed for streaming services)
          "media.eme.enabled" = true;
          "media.gmp-widevinecdm.enabled" = true;
        };

        # userChome.css remains the same
        userChrome = "
                    * { 
                        box-shadow: none !important;
                        border: 0px solid !important;
                    }

                    #tabbrowser-tabs {
                        --user-tab-rounding: 8px;
                    }

                    .tab-background {
                        border-radius: var(--user-tab-rounding) var(--user-tab-rounding) 0px 0px !important;
                        margin-block: 1px 0 !important;
                    }
                    
                    #scrollbutton-up, #scrollbutton-down {
                        border-top-width: 1px !important;
                        border-bottom-width: 0 !important;
                    }

                    .tab-background:is([selected], [multiselected]):-moz-lwtheme {
                        --lwt-tabs-border-color: rgba(0, 0, 0, 0.5) !important;
                        border-bottom-color: transparent !important;
                    }
                    
                    [brighttext='true'] .tab-background:is([selected], [multiselected]):-moz-lwtheme {
                        --lwt-tabs-border-color: rgba(255, 255, 255, 0.5) !important;
                        border-bottom-color: transparent !important;
                    }

                    /* Container color bar visibility */
                    .tabbrowser-tab[usercontextid] > .tab-stack > .tab-background > .tab-context-line {
                        margin: 0px max(calc(var(--user-tab-rounding) - 3px), 0px) !important;
                    }

                    #TabsToolbar, #tabbrowser-tabs {
                        --tab-min-height: 29px !important;
                    }
                    
                    #main-window[sizemode='true'] #toolbar-menubar[autohide='true'] + #TabsToolbar, 
                    #main-window[sizemode='true'] #toolbar-menubar[autohide='true'] + #TabsToolbar #tabbrowser-tabs {
                        --tab-min-height: 30px !important;
                    }
                    
                    #scrollbutton-up,
                    #scrollbutton-down {
                        border-top-width: 0 !important;
                        border-bottom-width: 0 !important;
                    }

                    #TabsToolbar, #TabsToolbar > hbox, #TabsToolbar-customization-target, #tabbrowser-arrowscrollbox  {
                        max-height: calc(var(--tab-min-height) + 1px) !important;
                    }
                    
                    #TabsToolbar-customization-target toolbarbutton > .toolbarbutton-icon, 
                    #TabsToolbar-customization-target .toolbarbutton-text, 
                    #TabsToolbar-customization-target .toolbarbutton-badge-stack,
                    #scrollbutton-up,#scrollbutton-down {
                        padding-top: 7px !important;
                        padding-bottom: 6px !important;
                    }
                ";
      };
    };
  };
}