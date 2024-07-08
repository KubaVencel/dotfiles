{ pkgs, config, lib, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Use the systemd-boot EFI boot loader.
  #boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # needed to unlock LUKS with key from TPM
  boot.initrd.systemd.enable = true;
  boot.kernelParams = [ 
];

specialisation = {
    sync.configuration = {
      system.nixos.tags = [ "sync" ];

      boot = {
          kernelParams =
            [ "acpi_rev_override" "mem_sleep_default=deep" "nvidia-drm.modeset=1" ];
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
