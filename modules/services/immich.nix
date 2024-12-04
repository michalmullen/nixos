{ config, pkgs, pkgs-unstable, lib, ... }:

{
  services.immich = {
    enable = true;
    environment.IMMICH_MACHINE_LEARNING_URL = "http://localhost:3003";
  };
  users.users.immich.extraGroups = [ "video" "render" ];
}