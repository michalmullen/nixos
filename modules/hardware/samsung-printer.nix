{ config, lib, pkgs, ... }:

with lib;

{
  options = {
    hardware.samsung-printer.enable = mkEnableOption "Samsung Xpress M2026 printer support";
  };

  config = mkIf config.hardware.samsung-printer.enable {
    # Enable CUPS printing service
    services.printing = {
      enable = true;
      drivers = with pkgs; [
        # Samsung unified Linux driver
        samsung-unified-linux-driver
        # Additional drivers that might be needed
        splix
        gutenprint
        hplip
      ];
    };

    # Enable automatic printer discovery
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    # Add printer-related packages to system
    environment.systemPackages = with pkgs; [
      cups
      system-config-printer  # GUI for printer configuration
      gtklp                   # GTK print dialog
    ];

    # Ensure necessary services are running
    systemd.services.cups-browsed.enable = true;

    # Open firewall for printer discovery and communication
    networking.firewall = {
      allowedTCPPorts = [ 631 ];  # CUPS
      allowedUDPPorts = [ 631 ];  # CUPS discovery
    };

    # Add lp group for printer access
    users.groups.lp = {};
  };
}
