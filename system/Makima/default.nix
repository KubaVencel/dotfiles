{ pkgs, config, lib, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
  
  # networking.wireless.enable = true;  
  # Enables wireless support via wpa_supplicant.
  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  # # needed to unlock LUKS with key from TPM
  # boot.initrd.systemd.enable = true;
  # boot.kernelParams = [
  # ];
  
  # Thermald proactively prevents overheating on Intel CPUs 
  # and works well with other tools.
  services.thermald.enable = true;

  # Fix Intel CPU Throttling on Linux
  services.throttled.enable = lib.mkDefault true;
  
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  boot.kernelParams = [
    "i915.enable_guc=2"
    "i915.enable_fbc=1"
    "i915.enable_psr=2"
  ];

  # Discarding unused blocks
  services.fstrim.enable = lib.mkDefault true;
  
  # GPU acceleration
  hardware.graphics.extraPackages = with pkgs; [ vaapiIntel intel-media-driver ];

  # Lid close behavior
  services.logind.settings.Login.HandleLidSwitch = "suspend-then-hibernate";
  services.logind.settings.Login.HandleLidSwitchExternalPower = "lock";
  services.logind.settings.Login.HandleLidSwitchDocked = "ignore";

  # one of "ignore", "poweroff", "reboot", "halt", "kexec", "suspend", "hibernate", "hybrid-sleep", "suspend-then-hibernate", "lock"

  # tlp : A common tool used to save power on laptops is tlp,# which has sensible defaults for most laptops. 
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 50;

      #Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
    };
  };
  
  # smartmontools is a package which provides tools for monitoring drives
  # which support the S.M.A.R.T. system for monitoring hard drive health.
  # It includes the smartd and smartctl programs.
    services.smartd = {
    enable = true;
    devices = [
      {
        device = "/dev/nvme0n1"; 
        # FIXME: Change this to your actual disk; use lsblk to find the appropriate value
      }
    ];
  };

  # fingerprint reader
  services.fprintd = {
    enable = true;
    #tod = {
    #  enable = true;
    #}; 
  };

  #security.pam.services.swaylock = {};
  security.pam.services.swaylock.fprintAuth = true;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  programs.steam = {
    enable = true;
    # remotePlay.openFirewall = true;
    # dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };  

  systemd.services.ModemManager = {
    enable = lib.mkForce true;
    wantedBy = [ "multi-user.target" "network.target" ];
  };

  specialisation = {
    sync.configuration = {
    system.nixos.tags = [ "sync" ];
    boot = {
      kernelParams =[ 
        "acpi_rev_override" 
        "mem_sleep_default=deep" 
        #"nvidia-drm.modeset=1" 
      ];
      # kernelPackages = pkgs.linuxPackages_5_4;
      # extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
      };
    };
  };

  # lanzaboote
  
  # Lanzaboote currently replaces the systemd-boot module.
  # This setting is usually set to true in configuration.nix
  # generated at installation time. So we force it to false
  # for now.
  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };
}
