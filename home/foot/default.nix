{
  pkgs,
  config,
  ...
}:
{
   programs.foot = {
    enable = true;
    #server.enable = true; // can't execute desktop files in that case
    settings = {
      main = {
        font = "JetBrains Mono Semi Bold:size=13";
        dpi-aware = false;
        pad = "0x0";
      };
      bell = {
        urgent = true;
      };
      scrollback = {
        lines = 8192;
      };
      # catppuccin
      colors = {
      	alpha = "0.75";
        foreground = "ebdbb2";
	background = "282828";

	regular0 = "282828";
	regular1 = "cc241d";
	regular2 = "98971a";
	regular3 = "d79921";
	regular4 = "458588";
	regular5 = "b16286";
	regular6 = "689d6a";
	regular7 = "a89984";
	
	bright0 = "928374";
	bright1 = "fb4934";
	bright2 = "b8bb26";
	bright3 = "fabd2f";
	bright4 = "83a598";
	bright5 = "d3869b";
	bright6 = "8ec07c";
	bright7 = "ebdbb2";
	
	selection-foreground = "ebdbb2";
	selection-background = "3c3836";

	search-box-no-match = "32392f fb4934";
	search-box-match = "b8bb26 3c3836";

	jump-labels = "1d2021 fabd2f";
	urls = "458588";
      };
    };
  };
}
