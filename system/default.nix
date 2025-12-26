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

    optimise.automatic = true;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1d";
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
    #desktopManager.gnome.enable = true;
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
  # systemd.user.services.kanshi = {
  #   description = "kanshi daemon";
  #   serviceConfig = {
  #     Type = "simple";
  #     ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
  #   };
  # };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vheac = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" "adbusers" "wireshark" "docker" ];
    shell = pkgs.fish;
  };

  # Yubikey
  services.udev = {
    packages = [ 
      pkgs.yubikey-personalization
    ];
    extraRules = ''
      ACTION=="remove",\
      ENV{ID_BUS}=="usb",\
      ENV{ID_MODEL_ID}=="0407",\
      ENV{ID_VENDOR_ID}=="1050",\
      ENV{ID_VENDOR}=="Yubico",\
      RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
      '';
    };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  
  security.pam.services = {
      swaylock = {
      u2fAuth = true;
    };
    # Configure PAM to use YubiKey for greetd
    greetd = {
      enableGnomeKeyring = true;
      u2fAuth = true;          # Enable U2F authentication
      yubicoAuth = true;       # Enable Yubico authentication
    };
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  security.pam.yubico = {
   enable = true;
   debug = true;
   mode = "challenge-response";
    id = [ 
      "31225898" 
      "31489112"
    ];
  };

  # List services that you want to enable:
  services = {
    #     # Whether to enable PCSC-Lite daemon, to access smart cards using SCard API (PC/SC). 
    pcscd.enable = true; 
    
    # Enable the OpenSSH daemon.
    openssh = {
  	enable = true;
  	# require public key authentication for better security
        settings = {
          PasswordAuthentication = false;
  	  KbdInteractiveAuthentication = false;
          #PermitRootLogin = "yes";
          PermitRootLogin = "no";
        };
      };
	
    # Enable tailscale
    tailscale.enable = true;

    # Enable mullvad
    mullvad-vpn.enable = true;

    # Dbus 
    dbus = {
      enable = true;
      packages = [ pkgs.gcr ];
    };	

    greetd = {
      enable = true;
      settings = {
          default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd sway";
          user = "greeter";
        };
      };
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
  
  environment.defaultPackages = [ ];

  environment.systemPackages = with pkgs; [
    # system
    linux-firmware  
    libdrm
    mesa

    exfat
    exfatprogs

    grc
    chayang
    light
    procps
    playerctl
    home-manager

    openssh
    polkit

    mullvad-vpn
    mullvad-browser

    yubioath-flutter
    yubikey-manager #ykman
    
    sbctl # secure boot keys
    glib # gsettings

    pulseaudioFull

    swww # wallpapers

    # system utils
    btop
    htop
    wget
    curl
    git

    neovim
    tmux
    gnome-bluetooth

    gnutls
    fastfetch
    networkmanagerapplet

    pulsemixer
    wl-clipboard
  ];

   xdg.portal = {
     enable = true;
     wlr.enable = true;
     configPackages = with pkgs; [
       xdg-desktop-portal-gtk
      ];
     extraPortals = [
       pkgs.xdg-desktop-portal-gnome
       pkgs.xdg-desktop-portal-gtk
       pkgs.xdg-desktop-portal-hyprland
      #pkgs.xdg-desktop-portal-kde
       pkgs.kdePackages.xdg-desktop-portal-kde
       pkgs.xdg-desktop-portal-wlr
     ];
   };

  # Gnome keyring
  services.gnome.gnome-keyring.enable = true;

   security = {
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

    fish.enable = true;
    zsh.enable = true;

    kdeconnect.enable = true;

    wireshark.enable = true;
  };

  boot = {
    # kernel
    kernelPackages = pkgs.linuxPackages_latest;
  
    # zen
    #kernelPackages = pkgs.linuxPackages_zen;

    # xan
    #kernelPackages = pkgs.linuxPackages_xanmod_latest

    # needed to unlock LUKS with key from TPM
    initrd.systemd.enable = true;
  
    # loader = {
    #   efi.canTouchEfiVariables = true;
    #   grub = {
    #     enable = true;
    #     device = "nodev";
    #     efiSupport = true;
    #     gfxmodeEfi = "2560x1080";
    #     theme = pkgs.catppuccin-grub;
    #   };
    # };

    plymouth = {
      enable = true;
      theme = "red_loader";
      themePackages = with pkgs; [
        # By default we would install all themes
        #colorfull_sliced, cuts, flame, pixels, red loader, slicer
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "red_loader" ];
        })
      ];
    };

    # Enable "Silent Boot"
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    loader.timeout = 0;
  };
}
