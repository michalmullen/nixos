{ config, pkgs, vars, ... }:

{
  imports = [
    ./core
    ./programs
  ];
}