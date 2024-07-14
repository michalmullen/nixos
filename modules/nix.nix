{ config, pkgs, ... }:

{  
  # enable flake
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}