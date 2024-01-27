{
  description = "Home Manager configuration of radioaddition";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    };

  outputs = { self, nixpkgs, home-manager, unstable, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations = {
      "aspirem" = home-manager.lib.homeManagerConfiguration {
	    extraSpecialArgs = {inherit inputs;};
        inherit pkgs;
        modules = [
          ./hosts/aspirem.nix
        ];
      };
      "galith" = home-manager.lib.homeManagerConfiguration {
	    extraSpecialArgs = {inherit inputs;};
        inherit pkgs;
        modules = [
          ./hosts/galith.nix
        ];
      };
    };
  };
}
