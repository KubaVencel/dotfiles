{
  pkgs,
  inputs,
  ...
}: {
  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = {
      base00 = "1e1e2e"; # Base
      base01 = "181825"; # Mantle
      base02 = "313244"; # Surface0
      base03 = "45475a"; # Surface1
      base04 = "585b70"; # Surface2
      base05 = "cdd6f4"; # Text
      base06 = "f5e0dc"; # Rosewater
      base07 = "b4befe"; # Lavender
      base08 = "f38ba8"; # Red
      base09 = "fab387"; # Peach
      base0A = "f9e2af"; # Yellow
      base0B = "a6e3a1"; # Green
      base0C = "94e2d5"; # Teal
      base0D = "89b4fa"; # Blue
      base0E = "cba6f7"; # Mauve
      base0F = "f2cdcd"; # Flamingo
    };

    # does not work >:(
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    image = ./img/girlOnRoofAnimeAestheticSunset.jpg;

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrains Mono Nerd Font";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sizes = {
        applications = 12;
        terminal = 15;
        desktop = 10;
        popups = 10;
      };
    };

    targets = {
      gtk.enable = true;
      gnome.enable = true;
      chromium.enable = true;
      spicetify.enable = true;
      grub.enable = true;
      grub.useImage = true;
      plymouth.enable = false;
      nixos-icons.enable = true;
    };

    autoEnable = true;
  };
}
