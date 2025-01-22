{ pkgs, lib, config, inputs, home-manager, nix-flatpak, ... }: {
imports = [
    inputs.home-manager.nixosModules.home-manager
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
    # Set either with just the appId in quotes ("com.app.app") or with the app/remote/etc in {} ({ appId = "com.app.app"; origin = "remote";  })
	# Cartridges, gnome-styled version of lutris
	{ appId = "page.kramo.Cartridges"; origin = "flathub-verified"; }
	# Collision, a hash checker
	{ appId = "dev.geopjr.Collision"; origin = "flathub-verified"; }
	# Discover-Overlay
	{ appId = "io.github.trigg.discover_overlay"; origin = "flathub-verified"; }
	# IRC Client
	{ appId = "org.gnome.Polari"; origin = "flathub-verified"; }
	# Gnome passwords, keys, gpg manager
	{ appId = "org.gnome.seahorse.Application"; origin = "flathub-verified"; }
	#helvum
	{ appId = "org.pipewire.Helvum"; origin = "flathub-verified"; }
	#lutris
	{ appId = "net.lutris.Lutris"; origin = "flathub-verified"; }
	#onionshare-gui
	{ appId = "org.onionshare.OnionShare"; origin = "flathub-verified"; }
	#picard
	{ appId = "org.musicbrainz.Picard"; origin = "flathub-verified"; }
	#protonmail-bridge
	{ appId = "ch.protonmail.protonmail-bridge"; origin = "flathub-verified"; }
	#tor-browser
	{ appId = "org.torproject.torbrowser-launcher"; origin = "flathub-verified"; }
	# Warp, a wormhole client
	{ appId = "app.drey.Warp"; origin = "flathub-verified"; }
	# Fotema, a photo viewer
	{ appId = "app.fotema.Fotema"; origin = "flathub-verified"; }
	# Dconf Editor
	{ appId = "ca.desrt.dconf-editor"; origin = "flathub-verified"; }
	# SimpleX Chat
	{ appId = "chat.simplex.simplex"; origin = "flathub-verified"; }
	# GPU Screen recorder
	{ appId = "com.dec05eba.gpu_screen_recorder"; origin = "flathub-verified"; }
	# Protontricks
	{ appId = "com.github.Matoking.protontricks"; origin = "flathub-verified"; }
	# Pods, a podman manager
	{ appId = "com.github.marhkb.Pods"; origin = "flathub-verified"; }
	# Flatseal, a flatpak permissions manager
	{ appId = "com.github.tchx84.Flatseal"; origin = "flathub-verified"; }
	# EasyEffects
	{ appId = "com.github.wwmm.easyeffects"; origin = "flathub-verified"; }
	# Bottles, a wine prefix manager
	{ appId = "com.usebottles.bottles"; origin = "flathub-verified"; }
	# Steam
	{ appId = "com.valvesoftware.Steam"; origin = "flathub"; }
	# Steam Proton Manager
	{ appId = "com.vysp3r.ProtonPlus"; origin = "flathub-verified"; }
	# Fragments, a GTK+ torrent client
	{ appId = "de.haeckerfelix.Fragments"; origin = "flathub-verified"; }
	# Snoop, search through file contents (rather than just names)
	{ appId = "de.philippun1.Snoop"; origin = "flathub-verified"; }
	# Metadata cleaner
	{ appId = "fr.romainvigier.MetadataCleaner"; origin = "flathub-verified"; }
	# Ente Auth, 2FA app
	{ appId = "io.ente.auth"; origin = "flathub-verified"; }
	# Steam Adwaita Theme
	{ appId = "io.github.Foldex.AdwSteamGtk"; origin = "flathub-verified"; }
	# BoxBuddy, graphical distrobox manager
	{ appId = "io.github.dvlv.boxbuddyrs"; origin = "flathub-verified"; }
	# Ignition, startup process manager
	{ appId = "io.github.flattool.Ignition"; origin = "flathub-verified"; }
	# Warehouse, flatpak manager
	{ appId = "io.github.flattool.Warehouse"; origin = "flathub-verified"; }
	# Flatsweep, flatpak remnant cleaner
	{ appId = "io.github.giantpinkrobots.flatsweep"; origin = "flathub-verified"; }
	# Video wallpaper
	{ appId = "io.github.jeffshee.Hidamari"; origin = "flathub-verified"; }
	# Discord client
	{ appId = "io.github.milkshiift.GoofCord"; origin = "flathub-verified"; }
	# LLM app
	{ appId = "io.github.qwersyk.Newelle"; origin = "flathub-verified"; }
	# GDM Settings
	{ appId = "io.github.realmazharhussain.GdmSettings"; origin = "flathub-verified"; }
	# WiVRn, SteamVR alternative
	{ appId = "io.github.wivrn.wivrn"; origin = "flathub-verified"; }
	# Bootable media creator
	{ appId = "io.gitlab.adhami3310.Impression"; origin = "flathub-verified"; }
	# Minecraft Bedrock Launcher
	{ appId = "io.mrarm.mcpelauncher"; origin = "flathub-verified"; }
	# Fedora Media Writer
	{ appId = "org.fedoraproject.MediaWriter"; origin = "flathub-verified"; }
	# GNOME Calculator
	{ appId = "org.gnome.Calculator"; origin = "flathub-verified"; }
	# GNOME Calendar
	{ appId = "org.gnome.Calendar"; origin = "flathub-verified"; }
	# GNOME Connection manager
	{ appId = "org.gnome.Connections"; origin = "flathub-verified"; }
	# GNOME Contacts
	{ appId = "org.gnome.Contacts"; origin = "flathub-verified"; }
	# Document viewer
	{ appId = "org.gnome.Evince"; origin = "flathub-verified"; }
	# GNOME Logs
	{ appId = "org.gnome.Logs"; origin = "flathub-verified"; }
	# Image Viewer
	{ appId = "org.gnome.Loupe"; origin = "flathub-verified"; }
	# GNOME Screenshot
	{ appId = "org.gnome.Snapshot"; origin = "flathub-verified"; }
	# GNOME Text Editor
	{ appId = "org.gnome.TextEditor"; origin = "flathub-verified"; }
	# Pika Backup
	{ appId = "org.gnome.World.PikaBackup"; origin = "flathub-verified"; }
	# Gnome Keepass client
	{ appId = "org.gnome.World.Secrets"; origin = "flathub-verified"; }
	# Disk usage analyzer
	{ appId = "org.gnome.baobab"; origin = "flathub-verified"; }
	# GNOME Clock
	{ appId = "org.gnome.clocks"; origin = "flathub-verified"; }
	# GNOME Font Viewer
	{ appId = "org.gnome.font-viewer"; origin = "flathub-verified"; }
	# Markdown text editor
	{ appId = "org.gnome.gitlab.somas.Apostrophe"; origin = "flathub-verified"; }
	# KeePassXC
	{ appId = "org.keepassxc.KeePassXC"; origin = "flathub-verified"; }
	# LocalSend
	{ appId = "org.localsend.localsend_app"; origin = "flathub-verified"; }
	# Parabolic
	{ appId = "org.nickvision.tubeconverter"; origin = "flathub-verified"; }
	# Helvum
	{ appId = "org.pipewire.Helvum"; origin = "flathub-verified"; }
	# PrismLauncher, minecraft launcher
	{ appId = "org.prismlauncher.PrismLauncher"; origin = "flathub-verified"; }
	# Signal
	{ appId = "org.signal.Signal"; origin = "flathub-verified"; }
	# Menu item editor
	{ appId = "page.codeberg.libre_menu_editor.LibreMenuEditor"; origin = "flathub-verified"; }
    ];
  };
}
