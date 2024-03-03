{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    oldpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    home-manager.url = "github:nix-community/home-manager";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-on-droid = {
      url = "github:t184256/nix-on-droid/release-23.05";
      inputs.nixpkgs.follows = "oldpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, unstable, oldpkgs, nix-on-droid, ... }@inputs:
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
      wordpress = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	specialArgs = {inherit inputs;};
	modules = [
	  ./containers/wordpress.nix
	];
      };
    };
    nixOnDroidConfigurations = {
      "pixel6" = nix-on-droid.lib.nixOnDroidConfiguration {
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./hosts/pixel6.nix ];
      };
    };
      homeConfigurations = {
      "aspirem" = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = {inherit inputs;};
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [
          ./home-manager/hosts/aspirem.nix
        ];
      };
      "galith" = home-manager.lib.homeManagerConfiguration {
	extraSpecialArgs = {inherit inputs;};
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [
          ./home-manager/hosts/galith.nix
        ];
      };
      "airendeavour" = home-manager.lib.homeManagerConfiguration {
	extraSpecialArgs = {inherit inputs;};
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [
          ./home-manager/hosts/airendeavour.nix
        ];
      };
      "pixel6" = nix-on-droid.lib.nixOnDroidConfiguration {
        extraSpecialArgs = { inherit inputs; };
        pkgs = nixpkgs.legacyPackages."aarch64-linux";
        modules = [ ./hosts/pixel6.nix ];
      };
    };
  };
}
