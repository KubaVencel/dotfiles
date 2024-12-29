{ pkgs, config, ... }: {
#Catppuccin
  catppuccin = {
    btop.enable = true;
    gtk.enable = false;
  };

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
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
     theme = {
       name = "Catppuccin-Mocha-Compact-Mauve-dark";
       package = pkgs.catppuccin-gtk.override {
         accents = [ "mauve" ];
         size = "compact";
         tweaks = [ "rimless" "black" ];
         variant = "mocha";
       };
     };

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

  # Now symlink the `~/.config/gtk-4.0/` folder declaratively:
  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };
}
