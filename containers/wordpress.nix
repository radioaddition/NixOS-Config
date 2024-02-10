{ config, lib, pkgs, ... }:

let

  # Auxiliary functions

  fetchPackage = { name, version, hash, isTheme }:
    pkgs.stdenv.mkDerivation rec {
      inherit name version hash;
      src = let type = if isTheme then "theme" else "plugin";
      in pkgs.fetchzip {
        inherit name version hash;
        url = "https://downloads.wordpress.org/${type}/${name}.${version}.zip";
      };
      installPhase = "mkdir -p $out; cp -R * $out/";
    };

  fetchPlugin = { name, version, hash }:
    (fetchPackage {
      name = name;
      version = version;
      hash = hash;
      isTheme = false;
    });

  fetchTheme = { name, version, hash }:
    (fetchPackage {
      name = name;
      version = version;
      hash = hash;
      isTheme = true;
    });

  # Plugins
  wp-migrate = (fetchPlugin {
    name = "duplicator";
    version = "1.5.7.1";
    hash = "sha256-js1gUbIO3h0c4G7YJPCbGK5uwP6n6WWnioMZUh/homs=";
  });
  aios = (fetchPlugin {
    name = "all-in-one-wp-security-and-firewall";
    version = "5.2.5";
    hash = "sha256-dUzEa2dWwJeB7XY1T+AaVKGcRX+bJsMJpYqsNWmuMA8=";
  });
  static-mail-sender-configurator = (fetchPlugin {
    name = "static-mail-sender-configurator";
    version = "0.10.0";
    hash = "sha256-mTABwTifX8VVL2GHY8buxC3N5ONPTJRxJ4XGHC5+PNc=";
  });
  wp-dark-mode = (fetchPlugin {
    name = "wp-dark-mode";
    version = "4.2.7";
    hash = "sha256-7zbitDuVHJz65z9QdNrbwh6RdC+R4gOaCrcS8sAKAgU=";
  });
  dark-mode-dashboard = (fetchPlugin {
    name = "dark-mode-for-wp-dashboard";
    version = "1.2.3";
    hash = "sha256-WGgmo+iHvVxKmfwy8+Xpu65eTlDkGsJSeZi8Kf7zPss=";
  });
  dracula-dark-mode = (fetchPlugin {
    name = "dracula-dark-mode";
    version = "1.0.8";
    hash = "sha256-NYvTUE1h5SpVBpAXLAZUlUyktgbhiRCBPWdFgM7bUSo=";
  });
  koko-analytics = (fetchPlugin {
    name = "koko-analytics";
    version = "1.3.4";
    hash = "sha256-w7mvDpF3DMzAxLFEFDogghsi26/ZPZ1CyHOV3pXptyQ=";
  });
  wordpress-seo = (fetchPlugin {
    name = "wordpress-seo";
    version = "21.7";
    hash = "sha256-8FWupBZOORvR2emL8+JU6FYpwyKFS2Xzzb/BvphvL8Y=";
  });

  # Themes
  #astra = (fetchTheme {
  #  name = "astra";
  #  version = "4.5.2";
  #  hash = "sha256-0o68hv9gagu3TXCP2BGReAPO8ePuG2PKCuxIh4qzOK8=";
  #});
  decorative = (fetchTheme {
    name = "decorative";
    version = "1.0.1";
    hash = "sha256-GuThPzTkn3WYBIkJAZFwgPafgxfGzsY2PJpRs+dmg58=";
  });

in {
  services = {
    nginx.virtualHosts."localhost" = {
    #  root = lib.mkForce "/data/wordpress/";
    };
    wordpress = {
      webserver = "nginx";
      sites."localhost" = {
        package = pkgs.wordpress6_4;
        plugins = { 
	  inherit aios;
	  inherit static-mail-sender-configurator;
	  inherit wp-migrate;
	  inherit wp-dark-mode;
	  inherit dark-mode-dashboard;
	  inherit dracula-dark-mode;
	  inherit koko-analytics;
	  inherit wordpress-seo;
        };
        themes = {
        #  inherit astra;
	  inherit decorative;
        };
        settings = { WP_DEFAULT_THEME = "decorative"; };
      };
    };
  };
}

