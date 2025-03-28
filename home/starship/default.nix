{ pkgs,lib, ... }: {
  programs.starship = {
      enable = true;
      settings = {
      format = lib.concatStrings [
      	"[█](bg:bg1 fg:fg0)"
	"$os" 
	"[](bg:blue fg:fg0)"
	"$directory"
	"[](bg:aqua fg:blue)"
	"$git_branch"
	"$git_status"
	"[](bg:green fg:aqua)"
	"$nodejs"
	"$c"
	"$rust"
	"$golang"
	"$php"
	"$java"
	"$kotlin"
	"$haskell"
	"$python"
	"[](bg:orange fg:green)"
	"$time"
	"[](fg:orange)"
	"$character"
      ];

      os = {  
	disabled = false;
	style = "bg:fg0 fg:bg1";
  	};

      os.symbols = {
	Windows = "󰍲 ";
	Ubuntu = "󰕈 ";
	SUSE = " ";
	Raspbian = "󰐿 ";
	Mint = "󰣭 ";
	Macos = "󰀵 ";
	Manjaro = " ";
	Linux = "󰌽 ";
	Gentoo = "󰣨 ";
	Fedora = "󰣛 ";
	Alpine = " ";
	Amazon = " ";
	Android = " ";
	Arch = "󰣇 ";
	Artix = " ";
	CentOS = " ";
	Debian = "󰣚 ";
	Redhat = "󱄛 ";
	RedHatEnterprise = "󱄛 ";
	NixOS = " ";
	};
	
      	directory = {
		style = "fg:bg1 bg:blue";
		format = "[ $path ]($style)";
		truncation_length = 3;
		truncation_symbol = "…/";
	      }; 
	
	directory.substitutions = {
		"Documents" = "󰈙 ";
		"Downloads" = " ";
		"Music" = "󰝚 ";
		"Pictures" = " ";
		"Developer" = "󰲋 ";
	      };

	git_branch = {
	  symbol = " ";
	  style = "bg:aqua";
	  format = "[[ $symbol $branch ](fg:bg1 bg:aqua)]($style)";
	  };

 	git_status = {
	  style = "bg:aqua";
	  format = "[[($all_status$ahead_behind )](fg:bg1 bg:aqua)]($style)";
	  };

	nodejs = {
		symbol = " ";
		style = "bg:green";
		format = "[[ $symbol( $version) ](fg:bg1 bg:green)]($style)";
	      };
	      
	c = {
		symbol = " ";
		style = "bg:green";
		format = "[[ $symbol( $version) ](fg:bg1 bg:green)]($style)";
	      };
	      
	rust = {
		symbol = " ";
		style = "bg:green";
		format = "[[ $symbol( $version) ](fg:bg1 bg:green)]($style)";
		};
	      
	golang = {
		symbol = " ";
		style = "bg:green";
		format = "[[ $symbol( $version) ](fg:bg1 bg:green)]($style)";
	      };

	php = {
		symbol = " ";
		style = "bg:green";
		format = "[[ $symbol( $version) ](fg:bg1 bg:green)]($style)";
	      };

	java = {
		symbol = " ";
		style = "bg:green";
		format = "[[ $symbol( $version) ](fg:bg1 bg:green)]($style)";
	      };


	kotlin = {
		symbol = " ";
		style = "bg:green";
		format = "[[ $symbol( $version) ](fg:bg1 bg:green)]($style)";
	      };

	haskell = {
		symbol = " ";
		style = "bg:green";
		format = "[[ $symbol( $version) ](fg:bg1 bg:green)]($style)";
		};
	      
	python = {
		symbol = " ";
		style = "bg:green";
		format = "[[ $symbol( $version) ](fg:bg1 bg:green)]($style)";
    	};

	time = {
		disabled = false;
		time_format = "%R";
		style = "bg:orange";
		format = "[[ $time ](fg:bg1 bg:orange)]($style)";
	};

    palette = "gruvbox_dark";

    palettes.gruvbox_dark = {
      fg0 = "#fbf1c7";
      bg1 = "#3c3836";
      bg3 = "#665c54";
      blue = "#458588";
      aqua = "#689d6a";
      green = "#98971a";
      orange = "#d65d0e";
      purple = "#b16286";
      red = "#cc241d";
      yellow = "#d79921";
      };
    };
  };
}

