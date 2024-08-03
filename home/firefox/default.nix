{ lib, inputs, pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.echoes = {
      search.default = "ecosia";
      search.engines = {
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
        "ecosia" = {
          urls = [{
            template = "https://www.ecosia.org/search?q=";
          }];
        };
      };
      
      search.force = true;

      bookmarks = [
        {
          name = "wikipedia";
          tags = [ "wiki" ];
          keyword = "wiki";
          url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
        }
      ];

      extraConfig = "${builtins.readFile ./user.js}";

      userChrome = "${builtins.readFile  ./userChrome.css}";	  
      
      userContent = "${builtins.readFile ./userContent.css}";

      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        bitwarden
	decentraleyes
	darkreader
        ublock-origin
	return-youtube-dislikes
        #sponsorblock
        #tridactyl
      ];

    };
  };
}
