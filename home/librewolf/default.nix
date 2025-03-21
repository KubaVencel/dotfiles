{ lib, inputs, pkgs, ... }:
{
  programs.librewolf = {
    enable = true;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
    };
    profiles.echoes = {
      search.engines = {
        "kagi" = {
          urls = [{ template = "https://kagi.com/search?q={searchTerms}"; }];
          #iconUpdateURL = " ";
          definedAliases = [ "@kagi" ];
        };
        "ecosia" = {
          urls = [{ template = "https://www.ecosia.org/search?q={searchTerms}"; }];
          iconUpdateURL = " ";
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
        ublock-origin
        privacy-badger
        return-youtube-dislikes
        #sponsorblock
        #tridactyl
      ];
      # https://www.deviceinfo.me/
    };
  };
}
