{ inputs, config, pkgs, vars, ... }:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./core
    ./programs
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}