{ inputs, config, pkgs, vars, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./core
    ./shell
    ./applications/alacritty.nix
    ./applications/ghostty.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}