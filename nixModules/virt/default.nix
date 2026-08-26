{
  config,
  pkgs,
  ... }:
{
  # Add user to libvirtd group
  users.users.vheac.extraGroups = [ "libvirtd" "podman" ];
  
  # Manage the virtualisation services
  virtualisation= {
    podman = {
      enable = true;
      dockerCompat = true;
    };
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        #ovmf.enable = true;
        #ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };

  programs = {
    virt-manager.enable = true;
  # Enable dconf (System Management Tool)
    dconf.enable = true;
  };

  services.spice-vdagentd.enable = true;

  environment.systemPackages = with pkgs; [
    qemu
    quickemu
    quickgui
    virt-manager
    virt-viewer
    spice spice-gtk
    spice-protocol
    virtio-win
    win-spice
    adwaita-icon-theme
  ];
}
