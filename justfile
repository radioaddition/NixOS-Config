argument := `hostname`
_default:
	@echo Available commands:
	@echo just install ACTION ARGUMENT
	@echo ""
	@echo Available ACTIONs:
	@echo "	disk: ARGUMENT should be a block device (ie /dev/sda)"
	@echo "	finish: ARGUMENT should be a hostname, defaults to {{argument}}"
	@echo "This script will first install a copy of its own flake to your disk (to avoid errors with the installer running out of storage)"
	@echo "Then, if you copy this script to the root folder of your nix config directory, will finish the install for you, automatically"
	@echo "adding your auto-generated hardware config (excluding filesystem information since you should have that preconfigured anyways)"
	@echo ""
	@echo "just format"
	@echo format the code in this repo
	@echo ""
	@echo "just fmt"
	@echo alias for \"just format\"
	@echo ""
	@echo "just clean"
	@echo clean out your nix store

# just install ACTION ARGUMENT
install action argument:
	#!/usr/bin/env bash
	set -euo pipefail
	if [ "{{action}}" == "finish" ]; then
		echo "This assumes you are on the #installer flake, CD'd into your nix config directory and have the remote authentication set up"
		nixos-generate-config --no-filesystems --root /tmp
		mv /tmp/etc/nixos/hardware-configuration.nix ./hosts/"{{argument}}"/
		rm -rf /tmp/etc
		if [ -d ".git" ]; then
			git add ./hosts/{{argument}}/hardware-configuration.nix
			git commit -m "add hardware-configuration.nix for {{argument}}"
			git push
		fi
		sudo nixos-rebuild switch --flake ".#{{argument}}"
		home-manager switch --flake ".#{{argument}}"
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
		sudo disko-install --flake ".#$hostname" --disk main "{{argument}}"
	fi
alias fmt := format

# Formats my spahetti code
format:
	deadnix --edit
	nix fmt

# Cleans out the nix store
clean:
	nix-collect-garbage -d
	nix profile wipe-history
	nh clean all
