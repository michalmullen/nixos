{ inputs, config, pkgs, vars, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./core
    ./shell
    ./applications/alacritty
    ./applications/ghostty
  ];

  # Note: nixpkgs.config is set at system level when using useGlobalPkgs
}