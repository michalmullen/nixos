{ config, pkgs, pkgs-unstable, lib, ... }:

{
  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.tailscale.enable = true;

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    allowedUDPPorts = [ 53317 ];
    allowedTCPPorts = [ 53317 ];
    allowedUDPPortRanges = [
      { from = 49152; to = 65535; }
    ];
    allowedTCPPortRanges = [
      { from = 49152; to = 65535; }
    ];
  };
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}