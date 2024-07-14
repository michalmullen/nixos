# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, pkgs-unstable, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/desktop.nix
      ../../modules/networking.nix
      ../../modules/nix.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "prodesk"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant. 

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.po252 = {
    isNormalUser = true;
    description = "Mitchell Mullen";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager.users.po252 = {
    imports = [
      ../../home/home.nix
      ../../home/gnome.nix
    ];
  };

  system.stateVersion = "24.05"; # Did you read the comment?

}
