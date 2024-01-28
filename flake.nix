{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {self, nixpkgs, home-manager, unstable, ... }@inputs:
  {
    nixosConfigurations = {
      galith = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	    specialArgs = {inherit inputs;};
        modules = [
          ./hosts/galith.nix
          ./hosts/galith-hardware.nix
        ];
      };
      aspirem = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/aspirem.nix
          ./hosts/aspirem-hardware.nix
        ];
      };
    };
      homeConfigurations = {
      "aspirem" = home-manager.lib.homeManagerConfiguration {
	    extraSpecialArgs = {inherit inputs;};
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          ./home-manager/hosts/aspirem.nix
        ];
      };
      "galith" = home-manager.lib.homeManagerConfiguration {
	    extraSpecialArgs = {inherit inputs;};
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          ./home-manager/hosts/galith.nix
        ];
      };
    };
  };
}
