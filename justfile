argument := `hostname`
keys := "microsoft"
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
	@echo ""
	@echo just secureboot-start
	@echo "start the setup for secureboot (this requires a reboot in between so two scripts are required)"
	@echo ""
	@echo just secureboot-finish KEYS
	@echo "finish setting up secureboot, where KEYS is one of \"microsoft\" or \"tpm-eventlog\" ({{keys}} is recommended and the default)"

# just install ACTION ARGUMENT
install action argument:
	#!/usr/bin/env bash
	set -euo pipefail
	# make annoying error shut up
	sudo mkdir -p /nix/var/nix/profiles/per-user/root/channels
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
		nixos-generate-config --no-filesystems --root /tmp
		mv /tmp/etc/nixos/hardware-configuration.nix ./hosts/installer/
		rm -rf /tmp/etc
		if [ -d ".git" ]; then
			git add ./hosts/installer/hardware-configuration.nix
		fi
		sudo disko-install --flake ".#installer" --disk main "{{argument}}"
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

# Sets up using these commands from the home directory
[no-cd]
setup:
	@ln -s "$PWD"/justfile "$HOME"/justfile
secureboot-start:
	sudo sbctl create-keys
	sudo sbctl verify
secureboot-finish keys:
	sudo sbctl enroll-keys --{{keys}}
