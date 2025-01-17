{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-on-droid.url = "github:t184256/nix-on-droid/release-24.05";
    fh.url = "https://flakehub.com/f/DeterminateSystems/fh/0.1.21.tar.gz";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, lanzaboote, home-manager, unstable, nix-on-droid, fh, ... }: {
    nixosConfigurations = {
      aspirem = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
	  lanzaboote.nixosModules.lanzaboote
          ./hosts/aspirem/configuration.nix
          ./hosts/aspirem/hardware-configuration.nix
	  home-manager.nixosModules.home-manager {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.radioaddition = [ import ./hosts/aspirem/home.nix ];
          }
	];
      };
      galith = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/galith/configuration.nix
          ./hosts/galith/hardware-configuration.nix
#	  home-manager.nixosModules.home-manager {
#	    home-manager.useGlobalPkgs = true;
#	    home-manager.useUserPackages = true;
#	    home-manager.users.radioaddition = [ import ./hosts/galith/home.nix ];
#	  }
        ];
      };
    };
    nixOnDroidConfigurations = {
      "oriole" = nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = import nixpkgs { system = "aarch64-linux"; };
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./hosts/oriole/configuration.nix ];
      };
    };
    homeConfigurations = {
      "aspirem" = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = {inherit inputs;};
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [
          ./hosts/aspirem/home.nix
        ];
      };
      "aspirem-secureblue" = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = {inherit inputs;};
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [
          ./hosts/aspirem-secureblue/home.nix
        ];
      };
      "oriole" = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = {inherit inputs;};
        pkgs = nixpkgs.legacyPackages."aarch64-linux";
        modules = [
          ./hosts/oriole/home.nix
        ];
      };
      "framework" = home-manager.lib.homeManagerConfiguration {
  	extraSpecialArgs = {inherit inputs;};
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [
          ./hosts/framework/home.nix
          ./hosts/framework/nushell.nix
        ];
      };
      "galith" = home-manager.lib.homeManagerConfiguration {
  	extraSpecialArgs = {inherit inputs;};
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [
          ./hosts/galith/home.nix
        ];
      };
      "deck" = home-manager.lib.homeManagerConfiguration {
  	extraSpecialArgs = {inherit inputs;};
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [
          ./hosts/deck/home.nix
        ];
      };
      "air2020" = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = {inherit inputs;};
        pkgs = nixpkgs.legacyPackages."x86_64-darwin";
        modules = [
          ./hosts/air2020/home.nix
        ];
      };
    };
  };
}
