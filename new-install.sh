#!/usr/bin/env bash
if [ "$2" == "" ]; then
	echo Usage: ./new-install.sh [hostname] [disk device]
	exit 1
fi
nixos-generate-config --no-filesystems --show-hardware-config >> ./hosts/$1/hardware-configuration.nix
git add ./hosts/$1/hardware-configuration.nix
rm -rf /tmp/etc
sudo nix --extra-experimental-features "nix-command flakes" run 'github:nix-community/disko/latest#disko-install' -- --flake .#"$1" --disk main "$2"
