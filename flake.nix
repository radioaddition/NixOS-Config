{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-on-droid = {
      url = "github:t184256/nix-on-droid/release-24.05";
    };
  };

  outputs = { self, nixpkgs, home-manager, unstable, nix-on-droid, ... }@inputs:
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
      "air2020" = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = {inherit inputs;};
        pkgs = nixpkgs.legacyPackages."x86_64-darwin";
        modules = [
          ./home-manager/hosts/air2020.nix
        ];
      };
    };
  };
}
