{ config, pkgs, lib, ... }: {
  imports = [
    ./swayApps
    ./swayApps/waybar/default.nix
    ./swayApps/wlogout/default.nix
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

    #extraOptions = [ 
    #  "--unsupported-gpu"
    #];

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
      terminal = "${pkgs.alacritty}/bin/alacritty";
      menu = "${pkgs.fuzzel}/bin/fuzzel";
      workspaceAutoBackAndForth = true;
      defaultWorkspace = "workspace number 1";

      startup = [
      	{ command = "swww-daemon"; }
        #{ command = "foot --server"; }
        #{ command = "pkill -SIGHUP kanshi"; always = true; }
        { command = "sleep 1 && swww img ~/nixModules/theming/themedImg/girlOnRoofAnimeAestheticSunset.jpg"; }
        { command = "autotiling";} 
        { command = "sleep 2 && firefox";} 
        { command = "alacritty";} 
        { command = "sleep 4 && cider-2";}
        { command = "sleep 5 && discord";} 
        { command = "sleep 6 && steam";} 
        { command = "sleep 7 && mullvad-vpn";}
      ];

      assigns = {
        "1" = [{ app_id = "firefox"; }];
        "2" = [{ app_id = "Alacritty"; }];
        "3" = [{ class = "steam"; }];
        "4" = [{ class = "discord"; }];        
      };

      # Move to scratchpad
      window.commands = [
        { criteria = { app_id = "Cider"; };
          command = "move scratchpad"; }

        { criteria = { app_id = ".blueman-manager-wrapped"; };
          command = "move scratchpad"; }
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
              app_id = "floating_foot$";
            }
          ];
        };

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
        "Dell Inc. DELL AW2723DF 5W3LNP3" = {
          mode = "2560x1440@239.970Hz";
          position = "0,0";
          scale = "1";
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
          # ====================
          # APPLICATION LAUNCHES
          # ====================
          
          # File manager in floating terminal
            "${mod}+o" = "exec ${floating_term} ${pkgs.lf}/bin/lf";
          
          # Application launcher/menu
            "${mod}+f" = "exec ${config.wayland.windowManager.sway.config.menu}";
          
          # Floating terminal
            "${mod}+Shift+Return" = "exec ${floating_term}";

          # ====================
          # BRIGHTNESS CONTROLS
          # ====================
          
            XF86MonBrightnessDown = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%-"; # ☀️⬇️ (Brightness down)

            XF86MonBrightnessUp = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%+"; # ☀️⬆️ (Brightness up)

          # ====================
          # AUDIO CONTROLS
          # ====================
          
            XF86AudioRaiseVolume = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +1%"; # 🔊 (Volume up)
            XF86AudioLowerVolume = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -1%"; # 🔉 (Volume down)
            XF86AudioMute = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle"; # 🔇 (Mute toggle)
            XF86AudioMicMute = "exec ${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle"; # 🎤🔇 (Mic mute)

          # ====================
          # MEDIA PLAYER CONTROLS
          # ====================
          
            XF86AudioPlay = "exec ${pkgs.playerctl}/bin/playerctl play-pause"; # ⏯️ (Play/pause)
            XF86AudioNext = "exec ${pkgs.playerctl}/bin/playerctl next"; # ⏭️ (Next track)
            XF86AudioPrev = "exec ${pkgs.playerctl}/bin/playerctl previous"; # ⏮️ (Previous track)
            XF86AudioStop = "exec ${pkgs.playerctl}/bin/playerctl stop"; # ⏹️ (Stop)
            Pause = "exec ${pkgs.playerctl}/bin/playerctl pause"; # ⏸️ (Pause key)

          # ====================
          # NOTIFICATION CONTROLS
          # ====================
          
            XF86NotificationCenter = "exec ${pkgs.mako}/bin/makoctl dismiss -a"; # 🔔 (Notification center)

          # ====================
          # DISPLAY CONTROLS
          # ====================
          
            XF86Display = "output eDP-1 toggle"; # 🖥️ (Display toggle)

          # ====================
          # SCREENSHOT CONTROLS
          # ====================
          
            "${mod}+p" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy output";
            Print = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy output"; # 🖨️ (Print screen)
            "${mod}+Shift+p" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy area";
            XF86SelectiveScreenshot = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy area"; # 📷 (Screenshot area)
            "${mod}+Ctrl+p" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy window";
           
          # ====================
          # WINDOW MANAGEMENT
          # ====================

          # Show cider
            "${mod}+m" = "[app_id=\"Cider\"] scratchpad show";

          # Toggle the current focus between tiling and floating mode
            "${mod}+Shift+space" = "floating toggle";
          
          # Move the currently focused window to the scratchpad          
            "${mod}+Shift+minus" = "move scratchpad";
          
          # Show the next scratchpad window or hide the focused scratchpad window.
          # If there are multiple scratchpad windows, this command cycles through them.
            "${mod}+minus" = "scratchpad show";

          # ====================
          # WORKSPACE NAVIGATION
          # ====================
          
            "${mod}+Ctrl+${up}" = "workspace prev_on_output";
            "${mod}+Ctrl+${down}" = "workspace next_on_output";
            "${mod}+Ctrl+Up" = "workspace prev_on_output";
            "${mod}+Ctrl+Down" = "workspace next_on_output";

            "${mod}+Ctrl+Shift+${up}" = "move container to workspace prev_on_output";
            "${mod}+Ctrl+Shift+${down}" = "move container to workspace next_on_output";
            "${mod}+Ctrl+Shift+Up" = "move container to workspace prev_on_output";
            "${mod}+Ctrl+Shift+Down" = "move container to workspace next_on_output";

          # ====================
          # MONITOR MANAGEMENT
          # ====================
          
            "${mod}+Ctrl+${left}" = "focus output left";
            "${mod}+Ctrl+${right}" = "focus output right";
            "${mod}+Ctrl+Left" = "focus output left";
            "${mod}+Ctrl+Right" = "focus output right";

            "${mod}+Ctrl+Shift+${left}" = "move workspace to output left";
            "${mod}+Ctrl+Shift+${right}" = "move workspace to output right";
            "${mod}+Ctrl+Shift+Left" = "move workspace to output left";
            "${mod}+Ctrl+Shift+Right" = "move workspace to output right";

          # ====================
          # ADDITIONAL MEDIA KEYS (XF86)
          # ====================
          
          # Application shortcuts
            XF86Calculator = "exec ${pkgs.gnome-calculator}/bin/gnome-calculator"; # 🧮 (Calculator)
            XF86Explorer = "exec ${pkgs.nemo}/bin/nemo"; # 📁 (File manager)
            XF86MyComputer = "exec ${pkgs.nemo}/bin/nemo ~"; # 🏠💻 (My computer)
            XF86WWW = "exec ${pkgs.firefox}/bin/firefox"; # 🌐 (Web browser)
            XF86HomePage = "exec ${pkgs.firefox}/bin/firefox"; # 🏠 (Home page)
            XF86Mail = "exec ${pkgs.thunderbird}/bin/thunderbird"; # 📧 (Mail client)
            XF86Search = "exec ${pkgs.fuzzel}/bin/fuzzel"; # 🔍 (Search)
            XF86Favorites = "exec ${pkgs.fuzzel}/bin/fuzzel"; # ⭐ (Favorites)
          
          # System control keys
            XF86Sleep = "exec systemctl suspend"; # 🌙 (Sleep)
            XF86Suspend = "exec systemctl suspend"; # 😴 (Suspend)
            XF86Hibernate = "exec systemctl hibernate"; # 🥶 (Hibernate)
            XF86PowerOff = "exec systemctl poweroff"; # ⏻ (Power off)
          
          # Hardware toggles
            XF86TouchpadToggle = "exec swaymsg input type:touchpad events toggle enabled disabled"; # 👆 (Touchpad toggle)
            XF86WLAN = "exec nmcli radio wifi"; # 📶 (WiFi toggle)
            XF86Bluetooth = "exec bluetoothctl power toggle"; # 📶🔵 (Bluetooth toggle)
          
          # Additional media keys
            XF86AudioMedia = "exec ${pkgs.playerctl}/bin/playerctl play-pause"; # 🎵 (Media key)
            XF86AudioRewind = "exec ${pkgs.playerctl}/bin/playerctl position 10-"; # ⏪ (Rewind 10s)
            XF86AudioForward = "exec ${pkgs.playerctl}/bin/playerctl position 10+"; # ⏩ (Forward 10s)
            XF86AudioRecord = "exec ${pkgs.playerctl}/bin/playerctl stop"; # 🔴 (Record key)
          
          # Launch keys
            XF86Tools = "exec ${floating_term}"; # 🔧 (Tools)
            XF86LaunchA = "exec ${pkgs.fuzzel}/bin/fuzzel"; # Ⓐ (Launch A)
            XF86LaunchB = "exec ${floating_term}"; # Ⓑ (Launch B)
          
          # Navigation keys
            XF86Back = "exec ${pkgs.playerctl}/bin/playerctl previous"; # ⬅️ (Back)
            XF86Forward = "exec ${pkgs.playerctl}/bin/playerctl next"; # ➡️ (Forward)
            XF86Refresh = "exec swaymsg reload"; # ♻️ (Refresh)
          
          # ====================
          # FULLSCREEN & MODES
          # ====================
          
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
        # ====================
        # CONFIG MODE - POWER OPTIONS
        # ====================  
          p = "exec swaynag -t warning -m 'Poweroff?' -b 'Yes' 'systemctl poweroff'; mode default"; # ⏻ Power off
          r = "exec swaynag -t warning -m 'Reboot?' -b 'Yes' 'systemctl reboot'; mode default"; # 🔄 Reboot
          s = "exec systemctl suspend; mode default"; # 🌙 Suspend
          "--release l" = "exec loginctl lock-session; mode default"; # 🔒 Lock session

        # ====================
        # CONFIG MODE - BRIGHTNESS
        # ====================
          
          b = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%+"; # ☀️⬆️ Brightness up
          "Shift+b" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%-"; # ☀️⬇️ Brightness down

        # ====================
        # CONFIG MODE - VOLUME
        # ====================
          v = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +1%"; # 🔊 Volume up
          "Shift+v" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -1%"; # 🔉 Volume down
          m = "exec ${pkgs.pulseaudio}/bin/pactSp1d3rl set-sink-mute @DEFAULT_SINK@ toggle"; # 🔇 Mute toggle
          "Shift+m" = "exec ${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle"; # 🎤🔇 Mic mute

        # ====================
        # CONFIG MODE - MEDIA
        # ====================
          z = "exec ${pkgs.playerctl}/bin/playerctl previous"; # ⏮️ Previous track
          x = "exec ${pkgs.playerctl}/bin/playerctl play-pause"; # ⏯️ Play/pause
          c = "exec ${pkgs.playerctl}/bin/playerctl next"; # ⏭️ Next track

        # ====================
        # CONFIG MODE - NOTIFICATIONS
        # ====================
          n = "exec ${pkgs.mako}/bin/makoctl dismiss -a"; # 🔔 Dismiss notifications

        # ====================
        # CONFIG MODE - EXIT
        # ====================
          Return = "mode default"; # ↩️ Exit config mode
          Escape = "mode default"; # ⎋ Exit config mode
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
