{
  description = "NixOS Config";

  inputs = {
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, lanzaboote, home-manager, unstable, nix-flatpak, ... }: {
    nixosConfigurations = {
      framework = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/framework/configuration.nix
          #./hosts/framework/hardware-configuration.nix # use the auto-generated config for now bc it's easier
	  ./base/system/base-gnome.nix
	  #./base/system/gaming.nix # Disable for vm testing bc I don't have the resources for that
	  ./base/system/networking.nix
	  ./base/system/packages.nix
	  ./base/system/security.nix
	  ./base/system/system.nix
	  ./base/system/users.nix
	  ./base/system/shells/fish.nix
#	  home-manager.nixosModules.home-manager {
#	    home-manager.useGlobalPkgs = true;
#	    home-manager.useUserPackages = true;
#	    home-manager.users.radioaddition = [ import ./hosts/galith/home.nix ];
#	  }
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
    homeConfigurations = {
      "aspirem" = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = { inherit inputs; };
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [
          ./hosts/aspirem/home.nix
        ];
      };
      "framework" = home-manager.lib.homeManagerConfiguration {
  	extraSpecialArgs = { inherit inputs; };
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [
	  nix-flatpak.homeManagerModules.nix-flatpak
          ./hosts/framework/home.nix
	  ./base/hm/home.nix
	  ./base/hm/gnome-extensions.nix
	  ./base/hm/flatpak.nix
	  ./base/hm/shells/fish.nix
        ];
      };
      "galith" = home-manager.lib.homeManagerConfiguration {
  	extraSpecialArgs = { inherit inputs; };
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [
          ./hosts/galith/home.nix
        ];
      };
      "deck" = home-manager.lib.homeManagerConfiguration {
  	extraSpecialArgs = { inherit inputs; };
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [
          ./hosts/deck/home.nix
        ];
      };
    };
  };
}
