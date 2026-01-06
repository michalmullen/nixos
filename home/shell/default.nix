{ config, pkgs, ... }:

{
  imports = [
    ./git
    ./nixvim
    ./tmux
    ./carapace
    ./zoxide
    ./starship
    ./atuin
    ./nushell
    ./bash
  ];
}