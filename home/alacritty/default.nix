{
  lib,
  pkgs,
  config,
  ...
}:
{
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    cursor = {
      style = {
        shape = "Block";
        blinking = "Off";
      };
    };
    
    font = {
      size = lib.mkDefault 13.0;

      offset = {
        x = 0;
        y = 0;
      };

      glyph_offset = {
        x = 0;
        y = 1;
      };

      normal = {
        family = "JetBrains Mono Nerd Font";
        style = "Medium";
      };
      bold = {
        family = "JetBrains Mono Nerd Font";
        style = "Heavy";
      };
      italic = {
        family = "JetBrains Mono Nerd Font";
        style = "Medium Italic";
      };
      bold_italic = {
        family = "JetBrains Mono Nerd Font";
        style = "Heavy Italic";
      };
    };

    mouse = {
      hide_when_typing = true;
    };
    
    #dynamic_padding = true;
    #dynamic_title = true;
    window.opacity = lib.mkForce 0.85;
  };
}
