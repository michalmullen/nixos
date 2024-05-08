{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Your custom packages and modifications, exported as overlays
    overlays = import ./nix/overlays;
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs: {

    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        inputs.home-manager.nixosModules.default
        inputs.nixos-hardware.nixosModules.framework-13-7040-amd
        inputs.overlays
        ./hosts/framework/configuration.nix
      ];
    };
  };
}