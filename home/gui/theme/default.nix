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
    cursorTheme = {
      
      #package = pkgs.bibata-cursors;
      #name = "Bibata-Original-Amber"; # Modern for rounded cursor
      
      #package = pkgs.banana-cursor;
      #name = "Banana";
      
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-light"; 

      size = 24;
    };

    gtk2.theme = {
      package = pkgs.gruvbox-dark-gtk;
      name = "gruvbox-dark";
    };

    gtk3.theme = {
      package = pkgs.gruvbox-dark-gtk;
      name = "gruvbox-dark";
    };

    gtk4.theme = {
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
    platformTheme.name = "gtk3";
    style.name = "kvantum";
  };

  home.packages = [
    (pkgs.gruvbox-kvantum.override { variant = "Gruvbox-Dark-Brown"; })
  ];

  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=Gruvbox-Dark-Brown
  '';

  dconf.settings."org/gnome/desktop/interface" = {
  gtk-theme = lib.mkForce "Gruvbox-Dark";
  icon-theme = lib.mkForce "Papirus-Dark";
  cursor-theme = lib.mkForce "phinger-cursors-light";
  color-scheme = "prefer-dark";  
  };
}
