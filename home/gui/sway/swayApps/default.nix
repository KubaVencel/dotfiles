{ pkgs, ... }: {
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
      font = "JetBrains-mono";
      font-size = 20;
      show-failed-attempts = true;
      daemonize = true;
      color = "282828";

      key-hl-color = "#689d6a";
      bs-hl-color = "#458088";
      caps-lock-bs-hl-color = "#b16286";
      caps-lock-key-hl-color = "#d65d0e";

      inside-color = "00000000"; 
      inside-clear-color = "00000000";
      inside-caps-lock-color = "00000000";
      inside-ver-color = "00000000";
      inside-wrong-color = "00000000";

      layout-bg-color = "00000000";
      layout-border-color = "00000000";
      layout-text-color = "#ebdbb2";

      line-color = "000000";
      line-clear-color = "00000000";
      line-caps-lock-color = "00000000";
      line-ver-color = "00000000";
      line-wrong-color = "00000000";

      ring-color = "#a89984";
      ring-clear-color = "#98971a";
      ring-caps-lock-color = "#d65d0e";
      ring-ver-color = "#458588";
      ring-wrong-color = "#cc241d";

      separator-color = "00000000";
      text-color = "#cdd6f4";
      text-clear-color = "#b8bb26";
      text-caps-lock-color = "#fe8019";
      text-ver-color = "#83a598";
      text-wrong-color = "#fb4934";    
    };
  };
}
