{ config, pkgs, pkgs-unstable, lib, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Enable plasma integration firefox
  # nixpkgs.config.firefox.enablePlasmaBrowserIntegration = true;
}
