{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      terminal.shell = {
        args = ["new-session"  "-A"  "-D" "-s" "main"];
        program = "${pkgs.tmux}/bin/tmux";
      };
    };
    theme = "tokyo_night";
  };
}
