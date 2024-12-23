# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, pkgs-unstable, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../../modules/default/location.nix
      ./../../modules/default/networking.nix
      ./../../modules/default/nix.nix
      ./../../modules/default/nixpkgs.nix
      ./../../modules/default/kde.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.luks.devices."luks-62176e26-d2bb-49da-a80e-c906d32c8086".device = "/dev/disk/by-uuid/62176e26-d2bb-49da-a80e-c906d32c8086";
  networking.hostName = "desktop"; # Define your hostname.

  # https://knowledgebase.frame.work/en_us/updating-fingerprint-reader-firmware-on-linux-for-13th-gen-and-amd-ryzen-7040-series-laptops-HJrvxv_za
  services.fwupd.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.po252 = {
    isNormalUser = true;
    description = "Mitchell Mullen";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      unstable.vscode
      obsidian
      localsend
      discord
      unstable.anytype
      libreoffice
      kate
      wine
      wine64
      unstable.lutris
      protonup-qt
    ];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  home-manager.users.po252 = {
    imports = [
      ../../home/home.nix
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    fwupd
    remmina
    rpi-imager
    prismlauncher
    spotify
    reaper
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}