{ config, pkgs, pkgs-unstable, lib, ... }:

{
  # enable flake
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.settings.auto-optimise-store = true;

  boot.loader.systemd-boot.configurationLimit = 8;
}