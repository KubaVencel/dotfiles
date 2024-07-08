{ pkgs, ... }: {
  programs.wlogout ={
    enable = true;
    layout = [
      {
        label = "lock";
        action = "swaylock";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
      {
        label = "logout";
        action = "loginctl terminate-user $USER";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
    ];
    
    style =  ''
      * {
        background-image: none;
      }

      window {
        background-color: rgba(30, 30, 46, 0.25);
      }
      
      button {
        color: rgba(17, 17, 27, 0.15);
        background-color: rgba(147, 153, 178, 0.45);
        #`border-style: solid;
        #border: 3px solid;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
      }
      
      button:active,
      button:focus,
      button:hover {
        color: rgba(17, 17, 27, 0.15);
        background-color: rgba(108, 112, 134, 0.50);
      }
      
      #lock {
        background-image: image(url("/home/vheac/home/gui/sway/swayApps/icons/lock.png"));
      }
      
      #logout {
        background-image: image(url("/home/vheac/home/gui/sway/swayApps/icons/logout.png"));
      }
      
      #suspend {
        background-image: image(url("/home/vheac/home/gui/sway/swayApps/icons/suspend.png"));
      }
      
      #hibernate {
        background-image: image(url("/home/vheac/home/gui/sway/swayApps/icons/hibernate.png"));
      }
      
      #shutdown {
        background-image: image(url("/home/vheac/home/gui/sway/swayApps/icons/shutdown.png"));
      }
      
      #reboot {
        background-image: image(url("/home/vheac/home/gui/sway/swayApps/icons/reboot.png"));
      }
      '';
    };
      
    services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.playerctl}/bin/playerctl -a pause; ${pkgs.swaylock}/bin/swaylock";
      }
      {
        event = "lock";
        command = "${pkgs.swaylock}/bin/swaylock";
      }
      {
        event = "unlock";
        command = "${pkgs.procps}/bin/pkill -USR1 swaylock";
      }
    ];
    extraArgs = [
      "idlehint 1200"
    ];
    timeouts = [
      {
        # turn the screen off quickly if the screen was locked manually
        timeout = 15;
        command = "${pkgs.procps}/bin/pgrep -x swaylock && \\
          ${pkgs.sway}/bin/swaymsg 'output * power off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * power on'";
      }
      {
        timeout = 900;
        command = "${pkgs.chayang}/bin/chayang -d10 && \\
          ${pkgs.sway}/bin/swaymsg 'output * power off' && \\
          ${pkgs.swaylock}/bin/swaylock";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * power on'";
      }
    ];
  };

  programs.swaylock = {
    enable = true;
    settings = {
      font = "JetBrains";
      font-size = 20;
      show-failed-attempts = true;
      daemonize = true;
      color = "1e1e2e";

      key-hl-color = "a6e3a1";
      bs-hl-color = "f5e0dc";
      caps-lock-bs-hl-color = "f5e0dc";
      caps-lock-key-hl-color = "a6e3a1";

      inside-color = "00000000"; 
      inside-clear-color = "00000000";
      inside-caps-lock-color = "00000000";
      inside-ver-color = "00000000";
      inside-wrong-color = "00000000";

      layout-bg-color = "00000000";
      layout-border-color = "00000000";
      layout-text-color = "cdd6f4";

      line-color = "00000000";
      line-clear-color = "00000000";
      line-caps-lock-color = "00000000";
      line-ver-color = "00000000";
      line-wrong-color = "00000000";

      ring-color = "b4befe";
      ring-clear-color = "f5e0dc";
      ring-caps-lock-color = "fab387";
      ring-ver-color = "89b4fa";
      ring-wrong-color = "eba0ac";

      separator-color = "00000000";
      text-color = "cdd6f4";
      text-clear-color = "f5e0dc";
      text-caps-lock-color = "fab387";
      text-ver-color = "89b4fa";
      text-wrong-color = "eba0ac";    
    };
  };
}
