{ config, pkgs, ... }:

{
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };
}
