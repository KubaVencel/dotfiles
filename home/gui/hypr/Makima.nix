{ pkgs, lib, config, hostname, ... }:

  let
    startScript = pkgs.writeShellScriptBin "start" ''
      #${pkgs.foot}/bin/foot --server &
      
      #systemctl --user import-environment PATH &
      #systemctl --user restart xdg-desktop-portal.service &

      # wait a tiny bit for wallpaper
      sleep 2
      ${pkgs.swww}/bin/swww img ~/nixModules/theming/themedImg/animeSkull.png
      '';

    # Terminal for floating windows (using alacritty from your config)
    floating_term = "${pkgs.alacritty}/bin/alacritty --class floating_foot";

in
  {  
  imports = [
    ./hyprApps/default.nix
    ./hyprApps/waybar/default.nix
    ./hyprApps/wlogout/default.nix
  ];
  
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
      settings = {
      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "swww-daemon"
        "${pkgs.bash}/bin/bash ${startScript}/bin/start"
        "waybar"
        "mako"
      ];

      general = {
        gaps_in = 2.5;
        gaps_out = 5;
        border_size = 2;
        "col.active_border" = "rgba(cba6f7d9) rgba(b4befed9) 60deg";
        "col.inactive_border" = "rgba(1e1e2ed9)";
        layout = "master";
      };

      monitor = "eDP-1, 1920x1080@60.03100, 0x0, 1.333333";

      env = [
        # "XCURSOR_SIZE,24"
        # "GBM_BACKEND,nvidia-drm"
        # "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        # "LIBVA_DRIVER_NAME,nvidia"
        # "XDG_SESSION_TYPE,wayland"
        # "__GL_GSYNC_ALLOWED"
        # "__GL_VRR_ALLOWED"
        # "MOZ_ENABLE_WAYLAND,1"
        # "WLR_RENDERER_ALLOW_SOFTWARE,1"
        # "QT_QPA_PLATFORM,wayland"
        # "SDL_VIDEODRIVER,wayland"
        # "WLR_DRM_NO_MODIFIERS=1"
      ];

      input = {
        kb_layout = "us, cz";
        kb_variant = "";
        kb_model = "";
        kb_options = "grp:alt_shift_toggle,caps:escape";

        kb_rules = "";

        follow_mouse = 1;

        touchpad = {
          natural_scroll = false;
        };

        repeat_rate = 40;
        repeat_delay = 250;
        force_no_accel = true;

        sensitivity = 0.0; # -1.0 - 1.0, 0 means no modification.
      };
        
      misc = {
        enable_swallow = true;
        force_default_wallpaper = 0;
        # swallow_regex = "^(Alacritty|wezterm)$";
      };

      # decoration = {
      #   # See https://wiki.hyprland.org/Configuring/Variables/ for more
      #
      #   rounding = 5;
      #
      #   drop_shadow = true;
      #   shadow_range = 30;
      #   shadow_render_power = 3;
      #   "col.shadow" = "rgba(1a1a1aee)";
      # };

      animations = {
        enabled = false;
        
        # bezier = [
        #   "smooth, 0.25, 0.46, 0.45, 0.94"
        #   "snappy, 0.16, 1, 0.3, 1" 
        #   "bouncy, 0.68, -0.55, 0.265, 1.55"
        #   "linear, 0, 0, 1, 1"
        #   "elastic, 0.175, 0.885, 0.32, 1.275"    # Elastic stretch
        #   "back, 0.68, -0.6, 0.32, 1.6"           # Back and forth
        #   "easeOut, 0, 0, 0.58, 1"                # Slow ending
        # ];
        #
        # animation = [
        #   # Window animations
        #   "windows, 1, 4, smooth"
        #   "windowsIn, 1, 4, smooth, gnomed"
        #   "windowsOut, 1, 4, smooth, gnomed"
        #   "windowsMove, 1, 4, smooth"
        #
        #   # Border animations
        #   "border, 1, 4, smooth"
        #   "borderangle, 1, 4, smooth"
        #
        #   # Fade animations
        #   "fade, 1, 4, smooth"
        #   "fadeIn, 1, 4, smooth"
        #   "fadeOut, 1, 4, smooth"
        #   "fadeSwitch, 1, 4, smooth"
        #   "fadeShadow, 1, 4, smooth"
        #   "fadeDim, 1, 4, smooth"
        #
        #   # Workspace animations
        #   "workspaces, 1, 4, smooth, fade"
        #   "specialWorkspace, 1, 4, smooth, slidevert"
        #
        #   # Layer animations (waybar, rofi, etc.)
        #   "layers, 1, 4, smooth"
        #   "layersIn, 1, 4, smooth, slide"
        #   "layersOut, 1, 4, smooth, slide"
        # ];
      };

      dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # you probably want this
      };

#     master = {
#       # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more new_is_master = true;
#       # orientation = "center";
#   };

      gestures = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
      };

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      "$mainMod" = "SUPER";

      # ====================
      # KEYBINDINGS
      # ====================
      bind =
        [
          # ====================
          # ORIGINAL KEYBINDS (preserved from your config)
          # ====================
          "$mainMod, return, exec, alacritty"
          "$mainMod SHIFT, Q, killactive,"
          "$mainMod SHIFT, M, exit,"
          "$mainMod SHIFT, space, togglefloating,"
          "$mainMod SHIFT, F, fullscreen,"
          "$mainMod, G, togglegroup,"
          "$mainMod, bracketleft, changegroupactive, b"
          "$mainMod, bracketright, changegroupactive, f"
          "$mainMod, f, exec, fuzzel"
          "$mainMod, P, pin, active"

          # Focus movement (vim keys)
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          "$mainMod, h, movefocus, l"
          "$mainMod, l, movefocus, r"
          "$mainMod, k, movefocus, u"
          "$mainMod, j, movefocus, d"

          # Window movement (vim keys)
          "$mainMod SHIFT, h, movewindow, l"
          "$mainMod SHIFT, l, movewindow, r"
          "$mainMod SHIFT, k, movewindow, u"
          "$mainMod SHIFT, j, movewindow, d"

          # ====================
          # NEW APPLICATION LAUNCHES (from Sway conversion)
          # ====================
          
          # File manager in floating terminal (changed from 'o' to avoid conflict)
          "$mainMod, O, exec, ${floating_term} ${pkgs.lf}/bin/lf"
          
          # Floating terminal (additional to your main terminal)
          "$mainMod SHIFT, Return, exec, ${floating_term}"
          
          # ====================
          # SCREENSHOT CONTROLS
          # ====================
          
          # Screenshot entire screen (using 'p' since 'P' is used for pin)
          "$mainMod CTRL, P, exec, ${pkgs.sway-contrib.grimshot}/bin/grimshot copy output"
          ", Print, exec, ${pkgs.sway-contrib.grimshot}/bin/grimshot copy output" # 🖨️
          
          # Screenshot selected area
          "$mainMod SHIFT, P, exec, ${pkgs.sway-contrib.grimshot}/bin/grimshot copy area"
          ", XF86SelectiveScreenshot, exec, ${pkgs.sway-contrib.grimshot}/bin/grimshot copy area" # 📷 
          
          # Screenshot current window
          "$mainMod ALT, P, exec, ${pkgs.sway-contrib.grimshot}/bin/grimshot copy window"
          
          # ====================
          # BRIGHTNESS CONTROLS
          # ====================
          
          ", XF86MonBrightnessDown, exec, ${pkgs.light}/bin/light -T 0.72" # ☀️⬇️ (Brightness down)
          ", XF86MonBrightnessUp, exec, ${pkgs.light}/bin/light -T 1.4" # ☀️⬆️ (Brightness up)
          ", XF86BrightnessDown, exec, ${pkgs.light}/bin/light -U 5" # 💡⬇️ (Alternative brightness down)
          ", XF86BrightnessUp, exec, ${pkgs.light}/bin/light -A 5" # 💡⬆️ (Alternative brightness up)
          
          # ====================
          # AUDIO CONTROLS
          # ====================
          
          ", XF86AudioRaiseVolume, exec, ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +1%" # 🔊 (Volume up)
          ", XF86AudioLowerVolume, exec, ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -1%" # 🔉 (Volume down)
          ", XF86AudioMute, exec, ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle" # 🔇 (Mute toggle)
          ", XF86AudioMicMute, exec, ${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle" # 🎤🔇 (Mic mute)
          
          # Alternative volume keys
          ", XF86VolumeUp, exec, ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +1%" # 🔊 (Alternative volume up)
          ", XF86VolumeDown, exec, ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -1%" # 🔉 (Alternative volume down)
          ", XF86VolumeMute, exec, ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle" # 🔇 (Alternative mute)
          
          # ====================
          # MEDIA PLAYER CONTROLS
          # ====================
          
          ", XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause" # ⏯️ (Play/pause)
          ", XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next" # ⏭️ (Next track)
          ", XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous" # ⏮️ (Previous track)
          ", XF86AudioStop, exec, ${pkgs.playerctl}/bin/playerctl stop" # ⏹️ (Stop)
          ", Pause, exec, ${pkgs.playerctl}/bin/playerctl pause" # ⏸️ (Pause key)
          
          # Additional media keys
          ", XF86AudioMedia, exec, ${pkgs.playerctl}/bin/playerctl play-pause" # 🎵 (Media key)
          ", XF86AudioRewind, exec, ${pkgs.playerctl}/bin/playerctl position 10-" # ⏪ (Rewind 10s)
          ", XF86AudioForward, exec, ${pkgs.playerctl}/bin/playerctl position 10+" # ⏩ (Forward 10s)
          ", XF86AudioRecord, exec, ${pkgs.playerctl}/bin/playerctl stop" # 🔴 (Record key)
          
          # ====================
          # NOTIFICATION CONTROLS
          # ====================
          
          ", XF86NotificationCenter, exec, ${pkgs.mako}/bin/makoctl dismiss -a" # 🔔 (Notification center)
          ", XF86Messenger, exec, ${pkgs.mako}/bin/makoctl dismiss -a" # 💬 (Messenger key)
          
          # ====================
          # DISPLAY CONTROLS
          # ====================
          
          ", XF86Display, exec, hyprctl dispatch dpms toggle" # 🖥️ (Display toggle)
          
          # ====================
          # SCRATCHPAD/SPECIAL WORKSPACE
          # ====================
          
          # Move window to scratchpad (special workspace)
          "$mainMod SHIFT, minus, movetoworkspacesilent, special"
          
          # Toggle scratchpad visibility
          "$mainMod, minus, togglespecialworkspace"
          
          # ====================
          # WORKSPACE NAVIGATION (Enhanced)
          # ====================
          
          # Navigate workspaces on current monitor
          "$mainMod CTRL, Up, workspace, m-1"
          "$mainMod CTRL, Down, workspace, m+1"
          
          # Move window to previous/next workspace
          "$mainMod CTRL SHIFT, Up, movetoworkspacesilent, m-1"
          "$mainMod CTRL SHIFT, Down, movetoworkspacesilent, m+1"
          
          # ====================
          # MONITOR MANAGEMENT
          # ====================
          
          # Focus different monitors
          "$mainMod CTRL, Left, focusmonitor, l"
          "$mainMod CTRL, Right, focusmonitor, r"
          
          # Move workspace to different monitors
          "$mainMod CTRL SHIFT, Left, moveworkspacetomonitor, current l"
          "$mainMod CTRL SHIFT, Right, moveworkspacetomonitor, current r"

          # ====================
          # MODE/SUBMAP TRIGGERS (Removed - using direct XF86 keys instead)
          # ====================
          
          # Alternative quick actions (if you miss the config mode)
          "$mainMod ALT, P, exec, systemctl poweroff" # Quick power off
          "$mainMod ALT, R, exec, systemctl reboot"   # Quick reboot
          "$mainMod ALT, S, exec, systemctl suspend"  # Quick suspend
          "$mainMod ALT, L, exec, loginctl lock-session" # Quick lock

          
          # ====================
          # MODE/SUBMAP TRIGGERS
          # ====================
          
          # Config mode trigger
          "$mainMod, C, submap, config"
          
          # ====================
          # APPLICATION SHORTCUTS (XF86 Keys)
          # ====================
          
          ", XF86Calculator, exec, ${pkgs.gnome-calculator}/bin/gnome-calculator" # 🧮 (Calculator)
          ", XF86Explorer, exec, ${pkgs.nemo}/bin/nemo" # 📁 (File manager)
          ", XF86MyComputer, exec, ${pkgs.nemo}/bin/nemo ~" # 🏠💻 (My computer)
          ", XF86WWW, exec, ${pkgs.firefox}/bin/firefox" # 🌐 (Web browser)
          ", XF86HomePage, exec, ${pkgs.firefox}/bin/firefox" # 🏠 (Home page)
          ", XF86Mail, exec, ${pkgs.thunderbird}/bin/thunderbird" # 📧 (Mail client)
          ", XF86Search, exec, fuzzel" # 🔍 (Search)
          ", XF86Favorites, exec, fuzzel" # ⭐ (Favorites)
          
          # ====================
          # SYSTEM CONTROL (XF86 Keys)
          # ====================
          
          ", XF86Sleep, exec, systemctl suspend" # 🌙 (Sleep)
          ", XF86Suspend, exec, systemctl suspend" # 😴 (Suspend)
          ", XF86Hibernate, exec, systemctl hibernate" # 🥶 (Hibernate)
          ", XF86PowerOff, exec, systemctl poweroff" # ⏻ (Power off)
          
          # ====================
          # HARDWARE TOGGLES (XF86 Keys)
          # ====================
          
          ", XF86TouchpadToggle, exec, hyprctl keyword 'device[touchpad]:enabled' 'toggle'" # 👆 (Touchpad toggle)
          ", XF86WLAN, exec, nmcli radio wifi" # 📶 (WiFi toggle)
          ", XF86Bluetooth, exec, bluetoothctl power toggle" # 📶🔵 (Bluetooth toggle)
          
          # ====================
          # LAUNCH KEYS (XF86 Keys)
          # ====================
          
          ", XF86Tools, exec, ${floating_term}" # 🔧 (Tools)
          ", XF86LaunchA, exec, fuzzel" # Ⓐ (Launch A)
          ", XF86LaunchB, exec, ${floating_term}" # Ⓑ (Launch B)
          
          # ====================
          # NAVIGATION KEYS (XF86 Keys)
          # ====================
          
          ", XF86Back, exec, ${pkgs.playerctl}/bin/playerctl previous" # ⬅️ (Back)
          ", XF86Forward, exec, ${pkgs.playerctl}/bin/playerctl next" # ➡️ (Forward)
          ", XF86Reload, exec, hyprctl dispatch forcerendererreload" # 🔄 (Reload)
          ", XF86Refresh, exec, hyprctl reload" # ♻️ (Refresh)
          
          # Mouse scroll wheel workspace switching (preserved from your config)
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
        ]

        # Workspace switching and window moving (preserved from your config)
        ++ map (n: "$mainMod SHIFT, ${toString n}, movetoworkspace, ${toString ( 
          if n == 0
            then 10
            else n
          )}") [1 2 3 4 5 6 7 8 9 0]
          ++ map (n: "$mainMod, ${toString n}, workspace, ${toString (
            if n == 0
            then 10
            else n
          )}") [1 2 3 4 5 6 7 8 9 0];

      # ====================
      # REPEATABLE BINDINGS (preserved from your config + new ones)
      # ====================
      
      binde = 
        [
          # Original window movement and resizing (preserved)
          "$mainMod SHIFT, h, moveactive, -20 0"
          "$mainMod SHIFT, l, moveactive, 20 0"
          "$mainMod SHIFT, k, moveactive, 0 -20"
          "$mainMod SHIFT, j, moveactive, 0 20"

          "$mainMod CTRL, l, resizeactive, 30 0"
          "$mainMod CTRL, h, resizeactive, -30 0"
          "$mainMod CTRL, k, resizeactive, 0 -10"
          "$mainMod CTRL, j, resizeactive, 0 10"
        ];

      # ====================
      # MOUSE BINDINGS (preserved from your config)
      # ====================
      
      bindm = 
        [
          # Move/resize windows with mainMod + LMB/RMB and dragging
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
      ];
      
      # ====================
      # BIND SETTINGS (preserved from your config)
      # ====================
      
      binds = {
        workspace_back_and_forth = 1;
        allow_workspace_cycles = 1;    
      };
    };
  };
}
