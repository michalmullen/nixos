{ config, pkgs, lib, ... }:

{
  # Enable flakes and nix-command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Deduplicate identical files in the store
  nix.settings.auto-optimise-store = true;

  # Binary caches — nix-community covers nixvim, home-manager, etc.
  nix.settings.substituters = [
    "https://cache.nixos.org"
    "https://nix-community.cachix.org"
  ];
  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCUSBd8="
  ];

  # Use all available cores; each job gets half the logical CPUs
  nix.settings.max-jobs = "auto";
  nix.settings.cores = 0; # 0 = use all cores for a single job when max-jobs allows

  # Reduce substituter connection timeout so a dead cache doesn't stall builds
  nix.settings.connect-timeout = 5;

  # Automatic garbage collection — keeps the store lean
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Keep only a small number of boot entries
  boot.loader.systemd-boot.configurationLimit = 8;
}