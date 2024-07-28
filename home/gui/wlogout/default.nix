{ pkgs, ... }: {
  programs.wlogout ={
    enable = true;
    layout = [
      {
        label = "lock";
        action = "swaylock";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
      {
        label = "logout";
        action = "loginctl terminate-user $USER";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
    ];
    
    style =  ''
      * {
        font-family: "JetBrains-mono";
        background-image: none;
	transition: 20ms;
	box-shadow: none;
      }

      window {
        background: linear-gradient(135deg, rgba(17, 17, 27, 0.25), rgba(17, 17, 27, 0.50));
        box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
        
        border: 1px; 
        border-style: solid;
        border-color: rgba(30, 30, 46, 0.25);
      }
      
      button {
        color: #a6adc8;
        font-size: 20px;
        
        background-repeat: no-repeat;
        background-color: rgba(17, 17, 27, 0.25);
        background-position: center;
        background-size: 25%;

        border-width: 1px; 
        border-style: solid;
        border-color: rgba(17, 17, 27, 0.5);

        margin: 1px;
      }
      
      
      button:active,
      button:hover {
        color: #a6adc8;
        background-color: rgba(17, 17, 27, 0.15);
      }

      #lock {
        background-image: image(url("/home/vheac/home/gui/wlogout/icons/lock.png"));
      }
      
      #logout {
        background-image: image(url("/home/vheac/home/gui/wlogout/icons/logout.png"));
      }
      
      #suspend {
        background-image: image(url("/home/vheac/home/gui/wlogout/icons/suspend.png"));
      }
      
      #hibernate {
        background-image: image(url("/home/vheac/home/gui/wlogout/icons/hibernate.png"));
      }
      
      #shutdown {
        background-image: image(url("/home/vheac/home/gui/wlogout/icons/shutdown.png"));
      }
      
      #reboot {
        background-image: image(url("/home/vheac/home/gui/wlogout/icons/reboot.png"));
      }
      '';
    };
}
