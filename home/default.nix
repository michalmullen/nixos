{ inputs, config, pkgs, vars, ... }:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./core
    ./programs
  ];
}