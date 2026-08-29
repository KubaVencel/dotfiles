{ pkgs, config, lib, ... }: 
{
home.pointerCursor = {
    enable = true;
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
    font = {
      name = "jetbrains-mono";
      size = 17;
    };

    cursorTheme = {
      
      #package = pkgs.bibata-cursors;
      #name = "Bibata-Original-Amber"; # Modern for rounded cursor
      
      #package = pkgs.banana-cursor;
      #name = "Banana";
      
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-light"; 

      size = 24;
    };

    gtk2= {
      theme = {
        package = pkgs.gruvbox-gtk-theme.override { colorVariants = [ "dark" ]; };
        name = "Gruvbox-dark";
      }; 
    };
    
    gtk3 = {
      theme = {
        package = pkgs.gruvbox-gtk-theme.override { colorVariants = [ "dark" ]; };
        name = "Gruvbox-dark";
      };
        extraConfig = {
          gtk-application-prefer-dark-theme = true;
        };
      };
    
    gtk4 = {
      theme = {
        package = pkgs.gruvbox-gtk-theme.override { colorVariants = [ "dark" ]; };
        name = "Gruvbox-dark";
      };
      extraConfig = {
        gtk-application-prefer-dark-theme = true;
        };
      };

      # icons 
    iconTheme = {
      package =  pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
  };

  
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";

    kvantum.settings.General = {
      theme = "Gruvbox-Dark-Brown";
    };
  };

  home.packages = [
    (pkgs.gruvbox-kvantum.override { variant = "Gruvbox-Dark-Brown"; })
  ];

  dconf.settings."org/gnome/desktop/interface" = {
    gtk-theme = lib.mkForce "Gruvbox-Dark";
    icon-theme = lib.mkForce "Papirus-Dark";
    cursor-theme = lib.mkForce "phinger-cursors-light";
    color-scheme = "prefer-dark";
  };
}
