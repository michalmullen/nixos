{ config, pkgs, pkgs-unstable, lib, ... }:

{
  # enable flake
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}