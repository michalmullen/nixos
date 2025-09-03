{ config, pkgs, ... }:

{
  imports = [
    ./ghostty.nix
    ./git.nix
    ./nixvim.nix
    ./shell.nix
    ./tmux.nix
  ];
}