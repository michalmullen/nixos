{ config, pkgs, ... }:

{

  # Enable networking
  networking.networkmanager.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

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

}