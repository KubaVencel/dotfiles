{ lib, pkgs, inputs, ... }: {
  nix = {
    # make nix3 commands consistent with the flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    settings = {
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  networking = {
    # Pick only one of the below networking options.
    # wireless.enable = true;
    networkmanager.enable = true;

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  # Set your time zone.
  time.timeZone = "Europe/Prague";


  # Select internationalisation properties.
  i18n.defaultLocale = "cs_CZ.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "cs_CZ.UTF-8";
    LC_IDENTIFICATION = "cs_CZ.UTF-8";
    LC_MEASUREMENT = "cs_CZ.UTF-8";
    LC_MONETARY = "cs_CZ.UTF-8";
    LC_NAME = "cs_CZ.UTF-8";
    LC_NUMERIC = "cs_CZ.UTF-8";
    LC_PAPER = "cs_CZ.UTF-8";
    LC_TELEPHONE = "cs_CZ.UTF-8";
    LC_TIME = "cs_CZ.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    xkb.layout = "cz";
    xkb.variant = "";
  };

  # Configure console keymap
    console.keyMap = "en";
  
  # Fonts
  fonts.packages = with pkgs; [
    jetbrains-mono
    source-code-pro
    pkgs.nerd-fonts.jetbrains-mono
    ];

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "lat2-terminus16";
    # keyMap = "us";
    # useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # kanshi systemd service
  systemd.user.services.kanshi = {
    description = "kanshi daemon";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vheac = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" "adbusers" "wireshark" "docker" ];
    shell = pkgs.zsh;
  };
  
  # List services that you want to enable:
  services = {
    # Enable the OpenSSH daemon.
    openssh = {
  	enable = true;
  	# require public key authentication for better security
  	settings.PasswordAuthentication = false;
  	settings.KbdInteractiveAuthentication = false;
  	#settings.PermitRootLogin = "yes";
	};
	
    # Enable tailscale
    tailscale.enable = true;

    # Dbus 
    dbus = {
      enable = true;
      packages = [ pkgs.gcr ];
    };	

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
          user = "greeter";
        };
      };
       vt = 7;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  boot.kernelPackages = pkgs.linuxPackages_latest;

  environment.defaultPackages = [ ];

  environment.systemPackages = with pkgs; [
    # system
    linux-firmware
    brightnessctl
    home-manager
    openssh
    polkit
    sbctl # secure boot keys
    libnotify
    glib # # gsettings
    pulseaudioFull
    autotiling
    light

    swww # wallpapers

    # essential system utils
    htop
    btop
    wget
    curl
    neovim
    tmux
    curl
    gnutls
    fastfetch
    networkmanagerapplet

    # non-essential programs
    pulsemixer
    git
    wl-clipboard
    neovim
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    
    configPackages = with pkgs; [
      xdg-desktop-portal-wlr
     ];
  
     # gtk portal needed to make gtk apps happy
    extraPortals = with pkgs; [
      #xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
      xdg-desktop-portal-kde
     ];
   };

   security = {
     pam.services.swaylock = {};

     polkit.enable = true;

     sudo.enable = true;

     # Needed for PipeWire
     rtkit.enable = true;
  };

  programs = {
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    light.enable = true;

    dconf.enable =true;

    zsh.enable = true;

    kdeconnect.enable = true;

    wireshark.enable = true;
  };

  # Fancy boot splash screen
  #boot.plymouth.enable = true;
}
