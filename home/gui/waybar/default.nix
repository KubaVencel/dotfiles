{ pkgs, ... }: {
  programs.waybar = {
    enable = true;
    style = ./waybar.css;
    settings = {
    mainBar = {
      layer= "top";
      position= "top";
      reload_style_on_change= true; 
      modules-left= [
        "custom/powermenu"
	"sway/workspaces"
  	"custom/arrow10"
      ];
    
      modules-center= [
        "sway/window"
      ];
    
      modules-right= [
        "tray"
        "custom/arrow8"
        "battery"
        "idle_inhibitor"
        "custom/arrow7"
    	"pulseaudio"
        "custom/arrow6"
        "network"
    	"custom/arrow5"
    	"memory"
      	"custom/arrow4"
      	"cpu"
      	"custom/arrow3"
      	"temperature"
      	"custom/arrow2"
        "clock#date"
        "custom/arrow1"
        "clock#time"
        "sway/language"
      ];

      "custom/powermenu"= {		
        "format"= " ";
      	"interval"= "once";
      	"on-click"= "wlogout";
      	"tooltip"= false;
      	"signal"= 8;
      };
	  
      tray = {
        icon-size = 18;
      };

      /* Modules */

      "sway/language" = {
        format = " {}";
        min-length = 5;
        on-click = "${pkgs.sway}/bin/swaymsg 'input * xkb_switch_layout next'";
        tooltip = false;
      };

      "clock#time" = {
        interval = 10;
        format = "{:%H:%M}";
        tooltip = false;
      };

      "clock#date" = {
        interval = 20;
        format = "{:%e %b %Y}";
        tooltip = false;
      };

      network = {
        interval = 5;
        format-wifi = " {essid} ({signalStrength}%)";
        format-ethernet = "󰈁 {ifname}";
        format-disconnected = "No connection";
        format-alt = "󰈀 {ipaddr}/{cidr}";
        tooltip = true;
        tooltip-format = " {bandwidthUpBits}  {bandwidthDownBits}";
      };
    
      cpu= {
        interval= 5;
      	tooltip= false;
      	format= "  {usage}%";
      	format-alt= "  {load}";
    	  states= {
    	    warning= 70;
      	    critical= 90;
          };
    	};
    
      memory= {
        interval= 5;
      	format= "  {used:0.1f}G/{total:0.1f}G";
      	states= {
    	  warning= 70;
      	  critical= 90;
        };
        tooltip= false;
      };

      sway= {
        format= "{}";
    	max-length= 30;
    	tooltip= false;
      };

      sway-workspaces= {
    	disable-scroll-wraparound= true;
      	smooth-scrolling-threshold= 4;
        enable-bar-scroll= true;
      };

      pulseaudio= {
        format= "{icon} {volume}%";
    	format-bluetooth= "{icon} {volume}%";
    	format-muted= " ";
    	format-icons= {
    	  headphone= " ";
    	  hands-free= "󰙌 ";
    	  headset= "󰋎 ";
    	  phone= " ";
    	  portable= " ";
    	  car= " ";
    	  default= [
            " "
            " "
          ];
        };
        scroll-step= 1;
    	on-click= "pactl set-sink-mute @DEFAULT_SINK@ toggle";
    	tooltip= false;
      };

      temperature= {
    	critical-threshold= 90;
      	interval= 5;
      	format= "{icon} {temperatureC}°";
      	format-icons= [
          ""
      	  ""
	  ""
    	  ""
    	  ""
        ];
        tooltip= false;
      };
      
      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
          };
          tooltip = false;
        };

      battery = {
        interval = 10;
        states = {
          warning = 30;
          critical = 15;
        };
        format-time = "{H}:{M:02}";
        format = "{icon} {capacity}% ({time})";
        format-charging = " {capacity}% ({time})";
        format-charging-full = " {capacity}%";
        format-full = "{icon} {capacity}%";
        format-alt = "{icon} {power}W";
        format-icons = [
          " "
          " "
          " "
          " "
          " "
        ];
        tooltip = false;
      };
          
      "custom/arrow1"= {
        format= "";
        tooltip= false;
      };
    
      "custom/arrow2"= {
    	format= "";
    	tooltip= false;
      };
    
      "custom/arrow3"= {
    	format= "";
    	tooltip= false;
      };
    
      "custom/arrow4"= {
    	format= "";
    	tooltip= false;
      };
    
      "custom/arrow5"= {
      	format= "";
      	tooltip= false;
      };
    
      "custom/arrow6"= {
    	format= "";
      	tooltip= false;
      };
    
      "custom/arrow7"= {
      	format= "";
      	tooltip= false;
      };
    
      "custom/arrow8"= {
      	format= "";
      	tooltip= false;
      };
    
      "custom/arrow9"= {
      	format= "";
      	tooltip= false;
      }; 
    
      "custom/arrow10"= {
    	format= "";
    	tooltip= false;
        };
      };
    };
  };
}
