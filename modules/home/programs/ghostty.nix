{ config, pkgs, ... }:

{
  home.file.".config/ghostty/config".text = ''
    command = tmux new-session -A -D -s main
  '';
}