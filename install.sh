#!/usr/bin/env bash
if [ "$1" == "" ]; then
	echo Usage: ./install.sh [disk device]
	echo OR
	echo ./install.sh finish [hostname]
	exit 1
fi
if [ "$1" == "finish" ]; then
	if [ "$2" == "" ]; then
		echo Usage: ./new-install.sh finish [hostname]
		echo "This assumes you are on the #installer flake, CD'd into your nix config directory and have the ssh keys set up for it"
	fi
	nixos-generate-config --no-filesystems --root /tmp
	mv /tmp/etc/nixos/hardware-configuration.nix ./hosts/$2/
	rm -rf /tmp/etc
	git add ./hosts/$2/hardware-configuration.nix
	git commit -m "add hardware-configuration.nix for $2"
	git push
	sudo nixos-rebuild switch --flake ".#$2"
	home-manager switch --flake ".#$2"
else
	nixos-generate-config --no-filesystems --root /tmp
	mv /tmp/etc/nixos/hardware-configuration.nix ./hosts/installer/
	rm -rf /tmp/etc
	git add ./hosts/installer/hardware-configuration.nix
	sudo nix --extra-experimental-features "nix-command flakes" run 'github:nix-community/disko/latest#disko-install' -- --flake '.#installer' --disk main "$1"
fi
