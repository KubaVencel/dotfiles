{ pkgs,lib, ... }: {
  programs.starship =
    let
      flavour = "mocha"; # One of `latte`, `frappe`, `macchiato`, or `mocha`
    in
    {
      enable = true;
      settings = {
      format = lib.concatStrings [
      	"[█](bg:base fg:text)"
	"$os" 
	"[](bg:lavender fg:text)"
	"$directory"
	"[](bg:blue fg:lavender)"
	"$git_branch"
	"$git_status"
	"[](bg:sapphire fg:blue)"
	"$nodejs"
	"$c"
	"$rust"
	"$golang"
	"$php"
	"$java"
	"$kotlin"
	"$haskell"
	"$python"
	"[](bg:teal fg:sapphire)"
	"$time"
	"[](fg:teal)"
	"$character"
      ];

      os = {  
	disabled = false;
	style = "bg:text fg:base";
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
		style = "fg:base bg:lavender";
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
	  style = "bg:blue";
	  format = "[[ $symbol $branch ](fg:base bg:blue)]($style)";
	  };

 	git_status = {
	  style = "bg:blue";
	  format = "[[($all_status$ahead_behind )](fg:base bg:blue)]($style)";
	  };

	nodejs = {
		symbol = " ";
		style = "bg:sapphire";
		format = "[[ $symbol( $version) ](fg:base bg:sapphire)]($style)";
	      };
	      
	c = {
		symbol = " ";
		style = "bg:sapphire";
		format = "[[ $symbol( $version) ](fg:base bg:sapphire)]($style)";
	      };
	      
	rust = {
		symbol = " ";
		style = "bg:sapphire";
		format = "[[ $symbol( $version) ](fg:base bg:sapphire)]($style)";
		};
	      
	golang = {
		symbol = " ";
		style = "bg:sapphire";
		format = "[[ $symbol( $version) ](fg:base bg:sapphire)]($style)";
	      };

	php = {
		symbol = " ";
		style = "bg:sapphire";
		format = "[[ $symbol( $version) ](fg:base bg:sapphire)]($style)";
	      };

	java = {
		symbol = " ";
		style = "bg:sapphire";
		format = "[[ $symbol( $version) ](fg:base bg:sapphire)]($style)";
	      };


	kotlin = {
		symbol = " ";
		style = "bg:sapphire";
		format = "[[ $symbol( $version) ](fg:base bg:sapphire)]($style)";
	      };

	haskell = {
		symbol = " ";
		style = "bg:sapphire";
		format = "[[ $symbol( $version) ](fg:base bg:sapphire)]($style)";
		};
	      
	python = {
		symbol = " ";
		style = "bg:sapphire";
		format = "[[ $symbol( $version) ](fg:base bg:sapphire)]($style)";
    	};

	time = {
		disabled = false;
		time_format = "%R";
		style = "bg:teal";
		format = "[[ $time ](fg:base bg:teal)]($style)";
	};

        palette = "catppuccin_${flavour}";
      }// builtins.fromTOML (builtins.readFile

        (pkgs.fetchFromGitHub
          {
            owner = "catppuccin";
            repo = "starship";
            rev = "5629d23"; # Replace with the latest commit hash
            sha256 = "sha256-nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
          } + /palettes/${flavour}.toml));
	};
}
