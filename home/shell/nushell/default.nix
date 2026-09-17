{ config, pkgs, sharedShellAliases, ... }:

{
  programs.nushell = {
    enable = true;
    shellAliases = sharedShellAliases // {
      ll = "ls -la";
    };
  };
}
