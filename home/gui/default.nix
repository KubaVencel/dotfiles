{ pkgs, ... }: {
  imports = [
    ./sway
    ./hypr
    ./waybar
    ./wlogout
    ./nixColors
    ./theme
  ];

  home.packages = with pkgs; [
    # fonts
    font-awesome
    bemoji

    # Sway
    linux-firmware
    swaylock
    swayidle
    brightnessctl
    wayland
    wlroots
    ];

# App launcher
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "SourceCodePro:size=13";
        dpi-aware = false;
        prompt = "'> '";
        terminal = "footclient";

        lines = 20;
        width = 60;
        horizontal-pad = 8;
        vertical-pad = 4;
        inner-pad = 4;

        exit-on-keyboard-focus-loss = false;
      };
      colors = {
        background = "1e1e2edd";
        text = "cdd6f4ff";
        match = "f5c2e7ff";
        selection = "181825ff";
	selection-match = "f2cdcdff";
        selection-text = "cdd6f4ff";
        border = "11111bff";
      };
      border = {
        width = 3;
        radius = 0;
      };
      key-bindings = {
        next = "Mod1+j Down Control+n";
        prev = "Mod1+k Up Control+p";
      };
    };
  };

# notifications 
  services.mako = {
    enable = true;
    font = "SourceCodePro 13";
    backgroundColor = "#1e1e2ee0";
    borderColor = "#cba6f7";
    textColor = "#cdd6f4";
    progressColor = "source #f5c2e7";
    borderRadius = 0;
    borderSize = 2;
    defaultTimeout = 5000;
    margin = "10";
    width = 400;
  };

  services.wlsunset = {
    enable = true;
    latitude = "49.06682";
    longitude = "17.45725";
    temperature.night = 4500;
  };
  
  # Calendar things
  programs = {
    khal = {
      enable = true;

      locale = {
        timeformat = "%H:%M";
        dateformat = "%d.%m";
        longdateformat = "%d.%m.%Y";
        datetimeformat = "%d.%m %H:%M";
        longdatetimeformat = "%d.%m.%Y %H:%M";
      };
    };
      vdirsyncer = {
      enable = true;
    };
  };

    programs.mpv = {
    enable = true;
    config = {
      osd-font = "SourceCodePro";
      osd-font-size = 20;
      osd-color = "#ebdbb2";
      osd-border-color = "#282828";
    };
    scripts = [
      pkgs.mpvScripts.mpris
    ];
  };

  programs.imv = {
    enable = true;
    settings = {
      options = {
        background = "282828";
        overlay_text_color = "ebdbb2";
        overlay_background_color = "282828";
        overlay_background_alpha = "e0";
        overlay_font = "JetBrains Mono:11";
      };
    };
  };

  programs.zathura = {
    enable = true;
    options = {
      font = "SourceCodePro 11";
      selection-clipboard = "clipboard";
      synctex-editor-command = "footclient nvim";

      #recolor = true;
      recolor-keephue = false;

      # base16 gruvbox
      default-bg = "#282828";
      default-fg = "#3c3836";
      statusbar-fg = "#bdae93";
      statusbar-bg = "#504945";
      inputbar-bg = "#282828";
      inputbar-fg = "#fbf1c7";
      notification-bg = "#282828";
      notification-fg = "#fbf1c7";
      notification-error-bg = "#282828";
      notification-error-fg = "#fb4934";
      notification-warning-bg = "#282828";
      notification-warning-fg = "#fb4934";
      highlight-color = "#fabd2f";
      highlight-active-color = "#83a598";
      completion-bg = "#3c3836";
      completion-fg = "#83a598";
      completion-highlight-fg = "#fbf1c7";
      completion-highlight-bg = "#83a598";
      recolor-lightcolor = "#282828";
      recolor-darkcolor = "#ebdbb2";
    };
  };
    
  fonts.fontconfig.enable = true;
}
