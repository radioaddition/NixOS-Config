{
  description = "spaghetti";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    oldstable.url = "github:NixOS/nixpkgs/nixos-24.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    disko.url = "github:nix-community/disko/latest";
    impermanence.url = "github:nix-community/impermanence";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    jovian-nixos = {
      url = "github:Jovian-Experiments/Jovian-NixOS";
      inputs.nixpkgs.follows = "unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "oldstable";
    };
  };

  outputs = inputs@{
    self,
    nixpkgs,
    unstable,
    nixos-hardware,
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
	  ./base/flatpak.nix
	  #./base/gaming.nix # Disable unless I'm using it
	  ./base/gnome.nix
	  ./base/networking.nix
	  ./base/packages.nix
	  ./base/security.nix
	  ./base/shells/fish.nix
	  ./base/system.nix
	  ./base/users.nix
          ./hosts/framework/configuration.nix
          ./hosts/framework/hardware-configuration.nix
	  ./init/disko.nix
	  ./init/filesystem.nix
	  ./init/impermanence.nix
          nixos-hardware.nixosModules.framework-13-7040-amd
	  disko.nixosModules.disko
	  home-manager.nixosModules.home-manager
	  impermanence.nixosModules.impermanence
	  lanzaboote.nixosModules.lanzaboote
	  nix-flatpak.nixosModules.nix-flatpak

	  {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "bak";
	    home-manager.users.radioaddition.imports = [
              ./base/home.nix
              ./hosts/framework/home.nix
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
	  ./base/users.nix
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
          ./base/home.nix
        ];
      };
      "oriole" = home-manager.lib.homeManagerConfiguration {
  	extraSpecialArgs = { inherit inputs; };
        pkgs = nixpkgs.legacyPackages."aarch64-linux";
        modules = [
	  ./base/home.nix
	  {
	    home = {
	      stateVersion = "24.05";
	      username = "nix-on-droid";
	      homeDirectory = "/data/data/com.termux.nix/files/home/";
	    };
	  }
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
