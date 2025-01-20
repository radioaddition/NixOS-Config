#!/usr/bin/env bash
if [ "$1" == "" ]; then
	echo Usage: ./new-install.sh [disk device]
	exit 1
fi
nixos-generate-config --no-filesystems --root /tmp
mv /tmp/etc/nixos/hardware-configuration.nix ./hosts/installer/
rm -rf /tmp/etc
git add ./hosts/installer/hardware-configuration.nix
sudo nix --extra-experimental-features "nix-command flakes" run 'github:nix-community/disko/latest#disko-install' -- --flake .#installer --disk main "$1"
