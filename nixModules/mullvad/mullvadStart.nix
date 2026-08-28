{ pkgs, ... }:
let
  mullvad-autostart = pkgs.makeAutostartItem {
    name = "mullvad-vpn";
    package = pkgs.mullvad-vpn;
  };
in
{
  environment.systemPackages = [ mullvad-autostart ];
}
