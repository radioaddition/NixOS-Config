#!/usr/bin/env bash
if [ "$2" == "" ]; then
	echo Usage: ./new-install.sh [hostname] [disk device]
	exit 1
fi
sudo nix --extra-experimental-features "nix-command flakes" run 'github:nix-community/disko/latest#disko-install' -- --flake .#"$1" --disk main "$2"
