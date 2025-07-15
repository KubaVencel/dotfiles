{
  pkgs,
  inputs,
  ...
}: 
{
   stylix = {
     enable = true;
     polarity = "dark";
     base16Scheme = {
       base00 = "282828"; # ----
       base01 = "3c3836"; # ---
       base02 = "504945"; # --
       base03 = "665c54"; # -
       base04 = "bdae93"; # +
       base05 = "d5c4a1"; # ++
       base06 = "ebdbb2"; # +++
       base07 = "fbf1c7"; # ++++
       base08 = "fb4934"; # Red
       base09 = "fe8019"; # Orange
       base0A = "fabd2f"; # Yellow
       base0B = "b8bb26"; # Green
       base0C = "8ec07c"; # Aqua/ Cyan
       base0D = "83a598"; # Blue
       base0E = "d3869b"; # Purple
       base0F = "d65d0e"; # Brown
     };
  
    # does not work >:(
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark.yaml";

    image = ./prismImg/anime_skull.png;
   
    #package = pkgs.capitaine-cursors-themed;
    #name = "Capitaine Cursors (Gruvbox) - White"; 

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
      console.enable = true;
    };

    autoEnable = false;
  };
}
