{ config, pkgs, ... }:

{
  programs.nushell = {
    enable = true;
    shellAliases = {
      cd = "z";
      ll = "ls -la";
      cat = "bat -p";
      vi = "nvim";
      lz = "lazygit";
      ghd = "GH_HOST=github.deutsche-boerse.de gh dash";
    };
  };
}
