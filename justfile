install:
	#!/usr/bin/env bash
	if [ "$1" == "" ]; then
		echo Usage: ./install.sh [disk device]
		echo OR
		echo ./install.sh finish [hostname]
		echo ""
		echo "This script will first install a copy of its own flake to your disk (to avoid errors with the installer running out of storage)"
		echo "Then, if you copy this script to the root folder of your nix config directory, will finish the install for you, automatically"
		echo "adding your auto-generated hardware config (excluding filesystem information since you should have that preconfigured anyways)"
		exit 1
	fi
	if [ "${1,,}" == "finish" ]; then
		echo "This assumes you are on the #installer flake, CD'd into your nix config directory and have the remote authentication set up"
		if [ "$2" == "" ]; then
			hostname="$(hostname)"
		else
			hostname="$2"
		fi
		nixos-generate-config --no-filesystems --root /tmp
		mv /tmp/etc/nixos/hardware-configuration.nix ./hosts/"$hostname"/
		rm -rf /tmp/etc
		if [ -d ".git" ]; then
			git add ./hosts/$hostname/hardware-configuration.nix
			git commit -m "add hardware-configuration.nix for $hostname"
			git push
		fi
		sudo nixos-rebuild switch --flake ".#$hostname"
		home-manager switch --flake ".#$hostname"
	else
		if [ "$(hostname)" == "installer" ]; then
			hostname="install_target"
		else
			hostname="installer"
		fi
		nixos-generate-config --no-filesystems --root /tmp
		mv /tmp/etc/nixos/hardware-configuration.nix ./hosts/$hostname/
		rm -rf /tmp/etc
		if [ -d ".git" ]; then
			git add ./hosts/$hostname/hardware-configuration.nix
		fi
		sudo nix --extra-experimental-features "nix-command flakes" run 'github:nix-community/disko/latest#disko-install' -- --flake ".#$hostname" --disk main "$1"
	fi
alias format := fix
alias fmt := fix
fix:
	deadnix --edit
	nix fmt
clean:
	nix-collect-garbage -d
	nix profile wipe-history
	nh clean all
test:
	#!/usr/bin/env bash
	echo $1
