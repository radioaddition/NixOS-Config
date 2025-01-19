#!/usr/bin/env bash
if [ "$2" == "" ]; then
	echo Usage: ./new-install.sh [hostname] [disk device]
	exit 1
fi
nixos-generate-config --root /tmp --no-filesystems
mv /tmp/etc/nixos/hardware-configuration.nix ./hosts/$1/
git add ./hosts/$1/hardware-configuration.nix
rm -rf /tmp/etc
sudo nix --extra-experimental-features "nix-command flakes" run 'github:nix-community/disko/latest#disko-install' -- --flake .#"$1" --disk main "$2"
