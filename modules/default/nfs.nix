{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nfs-utils
  ];

  networking.firewall = {
    enable = true;
    allowedUDPPorts = [ 111 2049 ];
    allowedTCPPorts = [ 111 2049 ];
  };

  networking.networkmanager.enable = true; networking.hosts = { "192.168.15.50" = [ "truenas" ]; };

  fileSystems."/home/po252/nfs" = { device = "truenas:/mnt/storage/nfs"; fsType = "nfs"; options = [ "x-systemd.automount" "noauto" ]; }; 
}