{ config, pkgs, lib, ... }: {
  imports = [
    ./swayApps
  ];
  
   home.sessionVariables = {
    # # Invisible cursor
    # WLR_NO_HARDWARE_CURSORS = "1";
    #
    #   # fix some java apps
    # _JAVA_AWT_WM_NONREPARENTING = "1";
    #
    # # General wayland environment variables
    # XDG_SESSION_TYPE = "wayland";
    # QT_QPA_PLATFORM = "wayland";
    # QT_WAYLAND_DISABLE_WINDOWDECORATION = "1"; 
    # SDL_VIDEODRIVER = "wayland";
    # GDK_BACKEND = "wayland";
    #
    # # Firefox wayland environment variable
    # MOZ_ENABLE_WAYLAND = "1";
    # MOZ_USE_XINPUT2 = "1";
    #
    # # OpenGL Variables
    # #LIBVA_DRIVER_NAME = "nvidia";
    # #GBM_BACKEND = "nvidia-drm";
    # __GL_GSYNC_ALLOWED = "0";
    # __GL_VRR_ALLOWED = "0";
    # #__GLX_VENDOR_LIBRARY_NAME = "nvidia";
    #
    # # Xwayland compatibility
    # XWAYLAND_NO_GLAMOR = "1";
   };

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;

    # Unbreak the backticks (home-manager#5311)
    checkConfig = false;

    systemd.enable = true;

    extraOptions = [ 
      "--unsupported-gpu"
    ];

      extraConfig = ''
      # Set floating window size constraints
      floating_maximum_size 1280 x 1080
      floating_minimum_size 920 x 580
    '';

    extraSessionCommands = ''
      # Invisible cursor
      # export WLR_NO_HARDWARE_CURSORS=1
      #
      # fix some java apps
      # export _JAVA_AWT_WM_NONREPARENTING=1
      #
      # General wayland environment variables
      # export XDG_SESSION_TYPE=wayland
      # export QT_QPA_PLATFORM=wayland
      # export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
      # export SDL_VIDEODRIVER=wayland
      #
      #
      # Firefox wayland environment variable
      # export MOZ_ENABLE_WAYLAND=1
      # export MOZ_USE_XINPUT2=1
      
      # OpenGL Variables
      # export GBM_BACKEND=nvidia-drm
      # export __GL_GSYNC_ALLOWED=0
      # export __GL_VRR_ALLOWED=0
      # export __GLX_VENDOR_LIBRARY_NAME=nvidia
      
      # Xwayland compatibility
      # export XWAYLAND_NO_GLAMOR=1
      
      # home-manager home.sessionVariables
      source ${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh
      
     # ln -s ~/.config/gtk-4.0/gtk.css ~/.config/gtk-3.0/gtk.css
      '';

    swaynag = {
      enable = true;
      settings = {
        "<config>" = {
          edge = "bottom";
          font = "JetBrains 11";
          border-bottom-size = "0";
        };
        warning = {
          background = "#282828";
          text = "#ebdbb2";
          border = "#cc241d";
          button-background = "#3c3836";
          button-text = "#fb4934";
        };  
      };
    };
          
    config = {
      modifier = "Mod4";
      bindkeysToCode = true;
      terminal = "${pkgs.foot}/bin/footclient";
      menu = "${pkgs.fuzzel}/bin/fuzzel";
      workspaceAutoBackAndForth = true;
      defaultWorkspace = "workspace number 1";

      startup = [
      	{ command = "swww-daemon"; }
        { command = "foot --server"; }
        { command = "pkill -SIGHUP kanshi"; always = true; }
        { command = "swww img ~/theming/img/anime_skull.png"; }
        { command = "autotiling";}
                ];

      bars = [
        {
          command = "${pkgs.waybar}/bin/waybar";
        }
      ];

      colors =
        let
          black = "#282828";
          red = "#cc241d";
          green = "#98971a";
          yellow = "#d79921";
          blue = "#458588";
          purple = "#b16286";
          aqua = "#689d61";
          gray = "#928374";
          brgray = "#a89983";
          brred = "#fb4934";
          brgreen = "#b8bb26";
          bryellow = "#fabd2f";
          brblue = "#83a598";
          brpurple = "#d3869b";
          braqua = "#8ec07c";
          white = "#ebdbb2";

          a = "e0";
          focused = green;
          inactive = blue;
          unfocused = black;
          urgent = red;
        in
        {
          focused = {
            border = focused;
            background = focused;
            text = black;
            indicator = brred;
            childBorder = "";
          };
          focusedInactive = {
            border = inactive;
            background = inactive;
            text = white;
            indicator = red;
            childBorder = "";
          };
          unfocused = {
            border = unfocused;
            background = unfocused;
            text = white;
            indicator = red;
            childBorder = "";
          };
          urgent = {
            border = urgent;
            background = urgent;
            text = black;
            indicator = red;
            childBorder = "";
          };
        };

        floating = {
          border = 2;
          titlebar = true;
          criteria = [
            {
              app_id = "^floating_foot$";
            }
          ];
        };

        #assigns = {
        #  "1" = [{ app_id = "org.qutebrowser.qutebrowser"; }];
        #  "2" = [{ app_id = "org.telegram.desktop"; }];
        #};

        focus = {
          newWindow = "urgent";
        };

        fonts = {
          names = [ "JetBrains" ];
          size = 13.0;
        };

        gaps = {
          smartGaps = true;
          smartBorders = "on";
          inner = 2;
          outer = 2;
        };

      output = {
        "AU Optronics 0x243D Unknown" = {
          mode = "1920x1080@60.031Hz";
          position = "0,0";
          scale = "1.3";
          scale_filter = "linear";
          transform = "normal";
          max_render_time = "off";
          adaptive_sync = "disabled";
        };
      };
      
      input = {
        "type:keyboard" = {
          xkb_layout = "us,cz";
          xkb_options = "grp:caps_toggle";
        };
      };

      keybindings =
        let
          mod = config.wayland.windowManager.sway.config.modifier;
          up = config.wayland.windowManager.sway.config.up;
          down = config.wayland.windowManager.sway.config.down;
          left = config.wayland.windowManager.sway.config.left;
          right = config.wayland.windowManager.sway.config.right;
          floating_term = "${config.wayland.windowManager.sway.config.terminal} -a floating_foot";
        in
        lib.mkOptionDefault {
          # File manager
          "${mod}+o" = "exec ${floating_term} ${pkgs.lf}/bin/lf";

          # Media keys
          XF86MonBrightnessDown = "exec ${pkgs.light}/bin/light -T 0.72";
          XF86MonBrightnessUp = "exec ${pkgs.light}/bin/light -T 1.4";

          XF86AudioRaiseVolume = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +1%";
          XF86AudioLowerVolume = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -1%";
          XF86AudioMute = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
          XF86AudioMicMute = "exec ${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle";

          XF86AudioPlay = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
          XF86AudioNext = "exec ${pkgs.playerctl}/bin/playerctl next";
          XF86AudioPrev = "exec ${pkgs.playerctl}/bin/playerctl previous";
          XF86AudioStop = "exec ${pkgs.playerctl}/bin/playerctl stop";
          Pause = "exec ${pkgs.playerctl}/bin/playerctl pause";

          XF86NotificationCenter = "exec ${pkgs.mako}/bin/makoctl dismiss -a";

          "${mod}+f" = "exec ${config.wayland.windowManager.sway.config.menu}";

          XF86Display = "output eDP-1 toggle";

          # General actions
          "${mod}+Shift+Return" = "exec ${floating_term}";

          "${mod}+p" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy output";
          Print = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy output";
          "${mod}+Shift+p" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy area";
          XF86SelectiveScreenshot = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy area";
          "${mod}+Ctrl+p" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy window";
           
          # Toggle the current focus between tiling and floating mode
          "${mod}+Shift+space" = "floating toggle";
          # Move the currently focused window to the scratchpad          
          "${mod}+Shift+minus" = "move scratchpad";
          # Show the next scratchpad window or hide the focused scratchpad window.
          # If there are multiple scratchpad windows, this command cycles through them.
          "${mod}+minus" = "scratchpad show";

          # Workspaces
          "${mod}+Ctrl+${up}" = "workspace prev_on_output";
          "${mod}+Ctrl+${down}" = "workspace next_on_output";
          "${mod}+Ctrl+Up" = "workspace prev_on_output";
          "${mod}+Ctrl+Down" = "workspace next_on_output";

          "${mod}+Ctrl+Shift+${up}" = "move container to workspace prev_on_output";
          "${mod}+Ctrl+Shift+${down}" = "move container to workspace next_on_output";
          "${mod}+Ctrl+Shift+Up" = "move container to workspace prev_on_output";
          "${mod}+Ctrl+Shift+Down" = "move container to workspace next_on_output";

          # Outputs
          "${mod}+Ctrl+${left}" = "focus output left";
          "${mod}+Ctrl+${right}" = "focus output right";
          "${mod}+Ctrl+Left" = "focus output left";
          "${mod}+Ctrl+Right" = "focus output right";

          "${mod}+Ctrl+Shift+${left}" = "move workspace to output left";
          "${mod}+Ctrl+Shift+${right}" = "move workspace to output right";
          "${mod}+Ctrl+Shift+Left" = "move workspace to output left";
          "${mod}+Ctrl+Shift+Right" = "move workspace to output right";

          # Global fullscreen
          "${mod}+Shift+f" = "fullscreen toggle global";

          # Modes
          "${mod}+Equal" = "mode passthrough";
          "${mod}+c" = "mode config";
        };
      modes = lib.mkOptionDefault {
        passthrough = {
          "${config.wayland.windowManager.sway.config.modifier}+Equal" =
            "mode default";
        };
      config = {
        p = "exec swaynag -t warning -m 'Poweroff?' -b 'Yes' 'systemctl poweroff'; mode default";
        r = "exec swaynag -t warning -m 'Reboot?' -b 'Yes' 'systemctl reboot'; mode default";
        s = "exec systemctl suspend; mode default";
        "--release l" = "exec loginctl lock-session; mode default";

        b = "exec ${pkgs.light}/bin/light -T 1.4";
        "Shift+b" = "exec ${pkgs.light}/bin/light -T 0.72";

        v = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +1%";
        "Shift+v" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -1%";
        m = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "Shift+m" = "exec ${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle";

        z = "exec ${pkgs.playerctl}/bin/playerctl previous";
        x = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
        c = "exec ${pkgs.playerctl}/bin/playerctl next";

        n = "exec ${pkgs.mako}/bin/makoctl dismiss -a";

        Return = "mode default";
        Escape = "mode default";
        };
      };

        seat = {
        "*" = {
            xcursor_theme = "${config.gtk.cursorTheme.name} ${toString config.gtk.cursorTheme.size}";
            hide_cursor = "4000";
            idle_inhibit = "keyboard touch switch";
          };
      };

      window = {
        border = 3;
        titlebar = false;
      };
    };
  };
}
