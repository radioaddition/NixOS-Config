{ config, lib, pkgs, stdenv, fetchurl, buildGoModule, distrobox, fetchFromGitHub, ... }:

# apx-gui 0.1.1
stdenv.mkDerivation rec {
  pname = "apx-git";
  version = "0.1.1";
  src = fetchurl {
    url = "https://github.com/Vanilla-OS/apx-gui/archive/refs/tags/v${version}.tar.gz";
    sha256 = "";
  };
  buildInputs = with pkgs; [
    meson
    libadwaita
    gettext
    desktop-file-utils
  ];
  buildPhase = "meson setup build && ninja -C build";
  installPhase = "sudo ninja -C build install";
}
