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
      	alpha = "0.7";
	
	foreground = "ebdbb2";
	background = "282828";
	
	regular0 = "282828"; # black
	regular1 = "cc241d";  # red
	regular2 = "98971a"; # green
	regular3 = "d79921"; # yellow
	regular4 = "458588"; # blue
	regular5 = "b16286"; # magenta
	regular6 = "689d6a"; # cyan
	regular7 = "a89984"; # white
	
	bright0 = "928374"; # bright black
	bright1 = "fb4934"; # bright red
	bright2 = "b8bb26"; # bright green
	bright3 = "fabd2f"; # bright yellow
	bright4 = "83a598"; # bright blue
	bright5 = "d3869b"; # bright magenta
	bright6 = "8ec07c"; # bright cyan
	bright7 = "ebdbb2"; # bright white
	selection-foreground = "282828";  # "<inverse foreground/background>";
	selection-background = "ebdbb2";  # "<inverse foreground/background>";
	
	jump-labels = "282828 d79921";	# "<regular0> <regular3>";
	urls = "458588"; # "<regular4>";
	scrollback-indicator = "282828 fb4934";  # "<regular0> <bright1>";
      };
    };
  };
}
