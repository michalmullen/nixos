{ config, pkgs, pkgs-unstable, lib, ... }:

{
    nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      permittedInsecurePackages = [
        "electron-25.9.0"
      ];
      packageOverrides = pkgs: {
        unstable = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {config.allowUnfree = true;};
      };      
    };
  };
}
