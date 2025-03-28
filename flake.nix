{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
   let
      # Replace with your username
      username = "po252";

      # Replace with the fitting architecture
      system = "x86_64-linux";
    in
   {
    nixosConfigurations.framework = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        inputs.home-manager.nixosModules.default
        inputs.nixos-hardware.nixosModules.framework-13-7040-amd
        ./hosts/framework/configuration.nix
      ];
    };
    nixosConfigurations.prodesk = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        inputs.home-manager.nixosModules.default
        ./hosts/prodesk/configuration.nix
      ];
    };
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        inputs.home-manager.nixosModules.default
        ./hosts/desktop/configuration.nix
      ];
    };
    homeConfigurations.lenovo-p1  = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system; };

        modules = [
          # Specify the path to your home configuration here:
          ./home/work.nix
          {
            home = {
              homeDirectory = "/home/${username}";
            };
          }
        ];
      };
    };
}
