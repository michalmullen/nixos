{ config, pkgs, inputs, lib, ... }:

{
    nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      permittedInsecurePackages = [
        "electron-25.9.0"
      ];
    };
    overlays = [
      (final: prev: {
        unstable = import inputs.nixpkgs-unstable {
          system = prev.system;
          config.allowUnfree = true;
        };
      })
    ];
  };
}
