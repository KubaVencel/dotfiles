{ pkgs, config, ... }: 
{
home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;

    #package = pkgs.bibata-cursors;
    #name = "Bibata-Original-Amber"; # Modern for rounded cursor

    # Banana
    #package = pkgs.banana-cursor;
    #name = "Banana";
    
    package = pkgs.phinger-cursors;
    name = "phinger-cursors-light"; 
    
    size = 24;
  };

  # gtk themegtk
  gtk = {
    enable = true;
    cursorTheme = {
      
      #package = pkgs.bibata-cursors;
      #name = "Bibata-Original-Amber"; # Modern for rounded cursor
      
      #package = pkgs.banana-cursor;
      #name = "Banana";
      
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-light"; 

      size = 24;
    };
    
    theme = {
      package = pkgs.gruvbox-dark-gtk;
      name = "gruvbox-dark";
    };

  # icons 
    iconTheme = {
      package =  pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
  };

   qt = {
      enable = true;
      platformTheme.name = "gtk2";
    };
}
