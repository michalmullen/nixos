{ config, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./git.nix
    ./nixvim.nix
    ./shell.nix
    ./tmux.nix
  ];
}