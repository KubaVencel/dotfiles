{ pkgs, config, ... }: 
{
home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;

    #package = pkgs.bibata-cursors;
    #name = "Bibata-Original-Amber"; # Modern for rounded cursor
    
    package = pkgs.capitaine-cursors-themed;
    name = "Capitaine Cursors (Gruvbox) - White"; 
    
    size = 24;
  };

  # gtk themegtk
  gtk = {
    enable = true;
    cursorTheme = {
      #package = pkgs.bibata-cursors;
      #name = "Bibata-Original-Amber"; # Modern for rounded cursor
      
      package = pkgs.capitaine-cursors-themed;
      name = "Capitaine Cursors (Gruvbox) - White"; 

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
      platformTheme.name = "gtk";
    };
}
