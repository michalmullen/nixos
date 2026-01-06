{ config, pkgs, ... }:

{
  programs.atuin = {
    enable = true;
    enableNushellIntegration = true;
    enableBashIntegration = true;
  };
}
