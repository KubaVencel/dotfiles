{ pkgs, config, ... }: {
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
