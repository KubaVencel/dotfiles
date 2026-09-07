{ lib, inputs, pkgs, config, ... }:
{
  programs.firefox = {
    enable = true;
    configPath = ".mozilla/firefox";
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value= true;
        #Locked= true;
        #Cryptomining= true;
        #Fingerprinting= true;
        #EmailTracking= true;
        #SuspectedFingerprinting= true;
        Category= "Standart";
      };
    };
    profiles.echoes = {
      search.engines = {
        "kagi" = {
          urls = [{ template = "https://kagi.com/search?q={searchTerms}"; }];
          icon = "https://kagi.com/asset/4f24904/kagi_assets/logos/yellow_3.svg";
          definedAliases = [ "@kagi" ];
        };
        "ecosia" = {
          urls = [{ template = "https://www.ecosia.org/search?q={searchTerms}"; }];
          icon = "https://images.seeklogo.com/logo-png/44/1/ecosia-logo-png_seeklogo-440094.png";
          definedAliases = [ "@ecosia" ];
        };

        "Nix Packages" = {
          urls = [{
            template = "https://search.nixos.org/packages";
            params = [
              { name = "type"; value = "packages"; }
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@np" ];
        };
      };
      
      search = {
        force = true;
        default = "kagi";
      };

      bookmarks = {
        force = true;
        settings = [
          {
            name = "wikipedia";
            tags = [ "wiki" ];
            keyword = "wiki";
            url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
        }
      ];
    };

      extraConfig = "${builtins.readFile ./user.js}";

      userChrome = "${builtins.readFile  ./userChrome.css}";	  
      
      userContent = "${builtins.readFile ./userContent.css}";

      extensions.packages = with inputs.firefox-addons.packages."x86_64-linux"; [
        bitwarden
	decentraleyes
	darkreader
        adnauseam
        new-tab-override
        tridactyl
        #privacy-badger
        #sponsorblock
        #ublock-origin
      ];
      # https://gitlab.com/rycee/nur-expressions/-/tree/master/pkgs/firefox-addons?ref_type=heads
      # https://www.deviceinfo.me/
    };
  };
}
