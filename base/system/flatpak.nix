{ pkgs, lib, config, inputs, home-manager, ... }: {
imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
    (lib.mkAliasOptionModule ["hm"] ["home-manager" "users" "radioaddition" ]) # Let us use hm as shorthand for home-manager config
  ];
  services.flatpak.enable = true;
  hm.services.flatpak = {
    uninstallUnmanaged = true;
    update.auto = {
      enable = true;
      onCalendar = "hourly";
    };
    remotes = [
      { name = "flathub-verified"; subset = "verified"; location = "https://flathub.org/repo/flathub.flatpakrepo"; }
      { name = "flathub"; location = "https://flathub.org/repo/flathub.flatpakrepo"; }
    ];
    packages = [
    # Set either with just the appID in quotes ("com.app.app") or with the app/remote/etc in {} ({ appId = "com.app.app"; origin = "remote";  })
	# Cartridges, gnome-styled version of lutris
	{ appID = "page.kramo.Cartridges"; origin = "flathub-verified"; }
	# Collision, a hash checker
	{ appID = "dev.geopjr.Collision"; origin = "flathub-verified"; }
	# Discover-Overlay
	{ appID = "io.github.trigg.discover_overlay"; origin = "flathub-verified"; }
	# IRC Client
	{ appID = "org.gnome.Polari"; origin = "flathub-verified"; }
	# Gnome passwords, keys, gpg manager
	{ appID = "org.gnome.seahorse.Application"; origin = "flathub-verified"; }
	#helvum
	{ appID = "org.pipewire.Helvum"; origin = "flathub-verified"; }
	#lutris
	{ appID = "net.lutris.Lutris"; origin = "flathub-verified"; }
	#onionshare-gui
	{ appID = "org.onionshare.OnionShare"; origin = "flathub-verified"; }
	#picard
	{ appID = "org.musicbrainz.Picard"; origin = "flathub-verified"; }
	#protonmail-bridge
	{ appID = "ch.protonmail.protonmail-bridge"; origin = "flathub-verified"; }
	#tor-browser
	{ appID = "org.torproject.torbrowser-launcher"; origin = "flathub-verified"; }
	# Warp, a wormhole client
	{ appID = "app.drey.Warp"; origin = "flathub-verified"; }
	# Fotema, a photo viewer
	{ appID = "app.fotema.Fotema"; origin = "flathub-verified"; }
	# Dconf Editor
	{ appID = "ca.desrt.dconf-editor"; origin = "flathub-verified"; }
	# SimpleX Chat
	{ appID = "chat.simplex.simplex"; origin = "flathub-verified"; }
	# GPU Screen recorder
	{ appID = "com.dec05eba.gpu_screen_recorder"; origin = "flathub-verified"; }
	# Protontricks
	{ appID = "com.github.Matoking.protontricks"; origin = "flathub-verified"; }
	# Pods, a podman manager
	{ appID = "com.github.marhkb.Pods"; origin = "flathub-verified"; }
	# Flatseal, a flatpak permissions manager
	{ appID = "com.github.tchx84.Flatseal"; origin = "flathub-verified"; }
	# EasyEffects
	{ appID = "com.github.wwmm.easyeffects"; origin = "flathub-verified"; }
	# Bottles, a wine prefix manager
	{ appID = "com.usebottles.bottles"; origin = "flathub-verified"; }
	# Steam
	{ appID = "com.valvesoftware.Steam"; origin = "flathub"; }
	# Steam Proton Manager
	{ appID = "com.vysp3r.ProtonPlus"; origin = "flathub-verified"; }
	# Fragments, a GTK+ torrent client
	{ appID = "de.haeckerfelix.Fragments"; origin = "flathub-verified"; }
	# Snoop, search through file contents (rather than just names)
	{ appID = "de.philippun1.Snoop"; origin = "flathub-verified"; }
	# Metadata cleaner
	{ appID = "fr.romainvigier.MetadataCleaner"; origin = "flathub-verified"; }
	# Ente Auth, 2FA app
	{ appID = "io.ente.auth"; origin = "flathub-verified"; }
	# Steam Adwaita Theme
	{ appID = "io.github.Foldex.AdwSteamGtk"; origin = "flathub-verified"; }
	# BoxBuddy, graphical distrobox manager
	{ appID = "io.github.dvlv.boxbuddyrs"; origin = "flathub-verified"; }
	# Ignition, startup process manager
	{ appID = "io.github.flattool.Ignition"; origin = "flathub-verified"; }
	# Warehouse, flatpak manager
	{ appID = "io.github.flattool.Warehouse"; origin = "flathub-verified"; }
	# Flatsweep, flatpak remnant cleaner
	{ appID = "io.github.giantpinkrobots.flatsweep"; origin = "flathub-verified"; }
	# Video wallpaper
	{ appID = "io.github.jeffshee.Hidamari"; origin = "flathub-verified"; }
	# Discord client
	{ appID = "io.github.milkshiift.GoofCord"; origin = "flathub-verified"; }
	# LLM app
	{ appID = "io.github.qwersyk.Newelle"; origin = "flathub-verified"; }
	# GDM Settings
	{ appID = "io.github.realmazharhussain.GdmSettings"; origin = "flathub-verified"; }
	# WiVRn, SteamVR alternative
	{ appID = "io.github.wivrn.wivrn"; origin = "flathub-verified"; }
	# Bootable media creator
	{ appID = "io.gitlab.adhami3310.Impression"; origin = "flathub-verified"; }
	# Minecraft Bedrock Launcher
	{ appID = "io.mrarm.mcpelauncher"; origin = "flathub-verified"; }
	# Fedora Media Writer
	{ appID = "org.fedoraproject.MediaWriter"; origin = "flathub-verified"; }
	# GNOME Calculator
	{ appID = "org.gnome.Calculator"; origin = "flathub-verified"; }
	# GNOME Calendar
	{ appID = "org.gnome.Calendar"; origin = "flathub-verified"; }
	# GNOME Connection manager
	{ appID = "org.gnome.Connections"; origin = "flathub-verified"; }
	# GNOME Contacts
	{ appID = "org.gnome.Contacts"; origin = "flathub-verified"; }
	# Document viewer
	{ appID = "org.gnome.Evince"; origin = "flathub-verified"; }
	# GNOME Logs
	{ appID = "org.gnome.Logs"; origin = "flathub-verified"; }
	# Image Viewer
	{ appID = "org.gnome.Loupe"; origin = "flathub-verified"; }
	# GNOME Screenshot
	{ appID = "org.gnome.Snapshot"; origin = "flathub-verified"; }
	# GNOME Text Editor
	{ appID = "org.gnome.TextEditor"; origin = "flathub-verified"; }
	# Pika Backup
	{ appID = "org.gnome.World.PikaBackup"; origin = "flathub-verified"; }
	# Gnome Keepass client
	{ appID = "org.gnome.World.Secrets"; origin = "flathub-verified"; }
	# Disk usage analyzer
	{ appID = "org.gnome.baobab"; origin = "flathub-verified"; }
	# GNOME Clock
	{ appID = "org.gnome.clocks"; origin = "flathub-verified"; }
	# GNOME Font Viewer
	{ appID = "org.gnome.font-viewer"; origin = "flathub-verified"; }
	# Markdown text editor
	{ appID = "org.gnome.gitlab.somas.Apostrophe"; origin = "flathub-verified"; }
	# KeePassXC
	{ appID = "org.keepassxc.KeePassXC"; origin = "flathub-verified"; }
	# LocalSend
	{ appID = "org.localsend.localsend_app"; origin = "flathub-verified"; }
	# Parabolic
	{ appID = "org.nickvision.tubeconverter"; origin = "flathub-verified"; }
	# Helvum
	{ appID = "org.pipewire.Helvum"; origin = "flathub-verified"; }
	# PrismLauncher, minecraft launcher
	{ appID = "org.prismlauncher.PrismLauncher"; origin = "flathub-verified"; }
	# Signal
	{ appID = "org.signal.Signal"; origin = "flathub-verified"; }
	# Menu item editor
	{ appID = "page.codeberg.libre_menu_editor.LibreMenuEditor"; origin = "flathub-verified"; }
    ];
  };
}
