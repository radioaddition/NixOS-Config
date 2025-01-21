{
  description = "spaghetti";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko/latest";
    impermanence.url = "github:nix-community/impermanence";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{
    self,
    nixpkgs,
    unstable,
    home-manager,
    disko,
    impermanence,
    lanzaboote,
    nix-flatpak,
    ... }: {

    nixosConfigurations = {

      framework = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
	  ./base/system/flatpak.nix
	  #./base/system/gaming.nix # Disable for vm testing bc I don't have the resources for that
	  ./base/system/gnome.nix
	  ./base/system/networking.nix
	  ./base/system/packages.nix
	  ./base/system/security.nix
	  ./base/system/shells/fish.nix
	  ./base/system/system.nix
	  ./base/system/users.nix
          ./hosts/framework/configuration.nix
          ./hosts/framework/hardware-configuration.nix
	  ./init/disko.nix
	  ./init/filesystem.nix
	  ./init/impermanence.nix
	  disko.nixosModules.disko
	  impermanence.nixosModules.impermanence
	  nix-flatpak.nixosModules.nix-flatpak
	  home-manager.nixosModules.home-manager {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.radioaddition = [
	      import base/hm/gnome-extensions.nix
	      import base/hm/shells/fish.nix
	      import base/hm/home.nix
	      import hosts/framework/home.nix
	    ];
	  }
        ];
      };

      installer = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
	  disko.nixosModules.disko
	  impermanence.nixosModules.impermanence
	  ./base/system/users.nix
          ./hosts/installer/configuration.nix
          ./hosts/installer/hardware-configuration.nix
	  ./init/disko.nix
	  ./init/filesystem.nix
	  ./init/impermanence.nix
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
