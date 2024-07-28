{ ... }: {
  services.kanshi = {
    enable = true;
    settings = [
      {
        profile = {
          name = "Power";
          outputs = [
            {
              criteria = "Dell Inc. DELL AW2723DF 5W3LNP3";
              status = "enable";
              mode = "2560x1440@239.970Hz";
            }
          ];
        };
      }
      {  
        profile = {
          name = "Makima";
          outputs = [
            {
            criteria = "eDP-1";
            status = "enable";
            mode = "1920x1080@60.031Hz";
            }
          ];
        };
      }
    ];
  };
}
