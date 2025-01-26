{ pkgs, config, ... }: {
# prism image recolor to theme  
prism = {
  enable = true;
  wallpapers = /home/vheac/stylix/img/;
  outPath = "/home/vheac/stylix/img/prism"; # Where in your home directory to output to.

  # There are a few different ways of setting the colorscheme.

  # If you pass the name it will use a lutgen builtin scheme
  colorscheme = "catppuccin-mocha"; 
  
  # If you pass a list of colors, it will build a scheme from them. 
  # They are formatted like base16 schemes
  # colorscheme = [ "FFFFFF" "FAFAFA" ... ]; 
 
  # You can also pass a nix-colors scheme attrset and it will parse the colors.
  # colorscheme = nix-colors.colorscheme.nord;
};
# Catppuccin
catppuccin = {
    flavor = "mocha";
    enable = true;
    
    # disable themed apps
    waybar.enable = false;
    wlogout.enable = false;
    mako.enable = false;
    imv.enable = false;

    gtk.enable = true;
    btop.enable = true;
  };

#cursorTheme themegtk
home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;

    package = pkgs.catppuccin-cursors.mochaLight;

    name = "catppuccin-mocha-light-cursors";

    size = 17;
   };

  # gtk themegtk
   gtk = {
     enable = true;
   # cursorTheme
     cursorTheme = {
       package = pkgs.catppuccin-cursors.mochaLight;
       name = "catppuccin-mocha-light-cursors";
     };

  # icons 
    iconTheme = {
      package =  pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
  };
}
