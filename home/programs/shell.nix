{ config, pkgs, ... }:

{
  # Shell tools configuration
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
    };
  };

  programs.nushell = {
    enable = true;
    shellAliases = {
      cd = "z";
      ll = "ls -la";
      cat = "bat -p";
      vi = "nvim";
      lz = "lazygit";
    };
  };
}
