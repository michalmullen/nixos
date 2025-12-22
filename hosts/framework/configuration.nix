# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ inputs, config, pkgs, vars, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../../modules/default/kde.nix
      ./../../modules/default/location.nix
      ./../../modules/default/networking.nix
      ./../../modules/default/nix.nix
      # ./../../modules/default/nfs.nix
      ./../../modules/default/nixpkgs.nix
      ./../../modules/default/gnupg.nix
      ./../../modules/hardware/samsung-printer.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "framework"; # Define your hostname.

  # https://knowledgebase.frame.work/en_us/updating-fingerprint-reader-firmware-on-linux-for-13th-gen-and-amd-ryzen-7040-series-laptops-HJrvxv_za
  services.fwupd.enable = true;

  # Enable Samsung printer support
  hardware.samsung-printer.enable = true;
  programs.nix-ld.enable = true;

  # Define a user account using global variables
  users.users.${vars.users.primary.username} = {
    isNormalUser = true;
    description = vars.users.primary.fullName;
    extraGroups = [ "networkmanager" "wheel" "lp" ];
    packages = with pkgs; [
      firefox
      obsidian
      localsend
      discord
      libreoffice
      qtpass
      xorg.xkill
      winbox4
    ];
  };

  # Use the new modular home configuration
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs vars; };
    users.${vars.users.primary.username} = {
      imports = [
        ../../home
      ];
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    fwupd
    remmina
    prismlauncher
    spotify
    reaper
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = vars.system.stateVersion;
}
