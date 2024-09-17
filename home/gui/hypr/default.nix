{ pkgs, lib, config, ... }:

  let
    startScript = pkgs.writeShellScriptBin "start" ''
      ${pkgs.swww}/bin/swww init &
      ${pkgs.foot}/bin/foor --server &

      export MOZ_ENABLE_WAYLAND=1
      
      systemctl --user import-environment PATH &
      systemctl --user restart xdg-desktop-portal.service &

      # wait a tiny bit for wallpaper
      sleep 2
      ${pkgs.swww}/bin/swww img ~/stylix/girlOnRoofAnimeAestheticSunset.jpg
  '';

in
{  
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    
	settings = {
	exec-once = [
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "${pkgs.bash}/bin/bash ${startScript}/bin/start"
          "waybar"
	  "mako"
        ];
	general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          "col.active_border" = "rgba(cba6f7d9) rgba(b4befed9) 60deg";
          "col.inactive_border" = "rgba(1e1e2ed9)";

          layout = "master";
        };
        
        monitor = ", preferred, auto, 1";
        
        env = [
          "XCURSOR_SIZE,24"
	  #"GBM_BACKEND,nvidia-drm"
   	  #"__GLX_VENDOR_LIBRARY_NAME,nvidia"
  	  #"LIBVA_DRIVER_NAME,nvidia"
    	  #"__GL_GSYNC_ALLOWED"
    	  #"__GL_VRR_ALLOWED"
	  #"MOZ_ENABLE_WAYLAND,1"
	  #"WLR_RENDERER_ALLOW_SOFTWARE,1"
      	  #"QT_QPA_PLATFORM,wayland"
	  #"SDL_VIDEODRIVER,wayland"
	  #"WLR_DRM_NO_MODIFIERS=1"
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

        decoration = {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          rounding = 5;

          drop_shadow = true;
          shadow_range = 30;
          shadow_render_power = 3;
          "col.shadow" = "rgba(1a1a1aee)";
        };

        animations = {
          enabled = true;

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = "myBezier, 0.25, 0.9, 0.1, 1.02";

          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            # "workspaces, 1, 3, default, slidevert"
            # "workspaces, 1, 3, myBezier, slidefadevert"
            "workspaces, 1, 3, myBezier, fade"
          ];
        };

        dwindle = {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true; # you probably want this
        };

#        master = {
#          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
#          new_is_master = true;
#          # soon :)
#          # orientation = "center";
#        };

        gestures = {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = false;
        };

        # See https://wiki.hyprland.org/Configuring/Keywords/ for more
        "$mainMod" = "SUPER";

        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        bind =
          [
            "$mainMod, return, exec, foot"
            "$mainMod, Q, killactive,"
            "$mainMod SHIFT, M, exit,"
            "$mainMod SHIFT, F, togglefloating,"
            "$mainMod, F, fullscreen,"
            "$mainMod, G, togglegroup,"
            "$mainMod, bracketleft, changegroupactive, b"
            "$mainMod, bracketright, changegroupactive, f"
            "$mainMod, SPACE, exec, fuzzel"
            "$mainMod, P, pin, active"

            "$mainMod, left, movefocus, l"
            "$mainMod, right, movefocus, r"
            "$mainMod, up, movefocus, u"
            "$mainMod, down, movefocus, d"

            "$mainMod, h, movefocus, l"
            "$mainMod, l, movefocus, r"
            "$mainMod, k, movefocus, u"
            "$mainMod, j, movefocus, d"

            "$mainMod SHIFT, h, movewindow, l"
            "$mainMod SHIFT, l, movewindow, r"
            "$mainMod SHIFT, k, movewindow, u"
            "$mainMod SHIFT, j, movewindow, d"

            # Scroll through existing workspaces with mainMod + scroll
            "bind = $mainMod, mouse_down, workspace, e+1"
            "bind = $mainMod, mouse_up, workspace, e-1"
          ]
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

        binde = [
          "$mainMod SHIFT, h, moveactive, -20 0"
          "$mainMod SHIFT, l, moveactive, 20 0"
          "$mainMod SHIFT, k, moveactive, 0 -20"
          "$mainMod SHIFT, j, moveactive, 0 20"

          "$mainMod CTRL, l, resizeactive, 30 0"
          "$mainMod CTRL, h, resizeactive, -30 0"
          "$mainMod CTRL, k, resizeactive, 0 -10"
          "$mainMod CTRL, j, resizeactive, 0 10"
        ];

        bindm = [
          # Move/resize windows with mainMod + LMB/RMB and dragging
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        	];

		};
	};
}
