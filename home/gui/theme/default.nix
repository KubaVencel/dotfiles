{ pkgs, config, ... }: {

#cursorTheme themegtk
catppuccin.flavor = "mocha";
#catppuccin.enable = true;

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
    # theme = {
    #   name = "Catppuccin-Mocha-Compact-Mauve-dark";
    #   package = pkgs.catppuccin-gtk.override {
    #     accents = [ "mauve" ];
    #     size = "compact";
    #     tweaks = [ "rimless" "black" ];
    #     variant = "mocha";
    #   };
    # };

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


  #   enable = true;
  #   platformTheme.name = "adwaita";
  #   style = {
  #       name = "Catppuccin Mocha Mauve Modern";
  #       package = pkgs.catppuccin-kde.override {
  #       flavour = [ "mocha" ];
  #       accents = [ "mauve" ];
  #       winDecStyles = [ "modern" ];
  #       };
  #     };
  #   };
}
