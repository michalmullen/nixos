{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
   let
      # Import global variables
      vars = import ./lib/vars.nix;

      # Common system configuration
      system = "x86_64-linux";

      # Helper function to create NixOS configuration
      mkNixosConfig = { hostName, modules ? [], extraSpecialArgs ? {} }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs vars;
          } // extraSpecialArgs;
          modules = [
            inputs.home-manager.nixosModules.default
          ] ++ modules;
        };
    in
   {
    nixosConfigurations.framework = mkNixosConfig {
      hostName = "framework";
      modules = [
        inputs.nixos-hardware.nixosModules.framework-13-7040-amd
        ./hosts/framework/configuration.nix
      ];
    };

    nixosConfigurations.prodesk = mkNixosConfig {
      hostName = "prodesk";
      modules = [
        ./hosts/prodesk/configuration.nix
      ];
    };

    nixosConfigurations.desktop = mkNixosConfig {
      hostName = "desktop";
      modules = [
        ./hosts/desktop/configuration.nix
      ];
    };
  };
}
