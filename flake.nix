{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    old.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";
    home-manager.url = "github:nix-community/home-manager";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-on-droid.url = "github:t184256/nix-on-droid/release-23.05";
    nix-on-droid.inputs.nixpkgs.follows = "old";
  };

  outputs = { self, nixpkgs, home-manager, unstable, old, nix-on-droid, nix-darwin, ... }@inputs:
  {

    # NixOS Configs

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

    # Nix for Android Configs

    nixOnDroidConfigurations = {
      "pixel6" = nix-on-droid.lib.nixOnDroidConfiguration {
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./hosts/pixel6.nix ];
      };
    };

    # MacOS Nix Configs

    darwinConfigurations = {
      "air2020" = nix-darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          ./hosts/air2020.nix
        ];
      };
    };

      # home-manager configs (mostly host-agnostic)

      homeConfigurations = {

      # NixOS home configs

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

      # Android home configs

      "pixel6" = nix-on-droid.lib.nixOnDroidConfiguration {
        extraSpecialArgs = { inherit inputs; };
        pkgs = nixpkgs.legacyPackages."aarch64-linux";
        modules = [ ./hosts/pixel6.nix ];
      };

      # MacOS home configs

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
