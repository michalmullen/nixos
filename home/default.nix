{ inputs, config, pkgs, vars, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./core
    ./shell
    ./applications/alacritty
    ./applications/ghostty
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}