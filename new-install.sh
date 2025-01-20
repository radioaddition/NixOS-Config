#!/usr/bin/env bash
if [ "$2" == "" ]; then
	echo Usage: ./new-install.sh [hostname] [disk device]
	exit 1
fi
nixos-generate-config --no-filesystems --root /tmp
mv /tmp/etc/nixos/hardware-configuration.nix ./hosts/$1/
rm -rf /tmp/etc
git add ./hosts/$1/hardware-configuration.nix
sudo nix --extra-experimental-features "nix-command flakes" run 'github:nix-community/disko/latest#disko-install' -- --flake .#"$1" --disk main "$2"
