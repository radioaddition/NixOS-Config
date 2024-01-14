{ config, lib, pkgs, stdenv, fetchurl, distrobox, ... }:

# apx 2.1.1
stdenv.mkDerivation rec {
  pname = "apx";
  version = "2.1.1";
  src = fetchurl {
    url = "https://github.com/Vanilla-OS/apx/archive/refs/tags/v${version}.tar.gz";
    sha256 = "";
  };
  buildInputs = with pkgs; [
    go
    gnumake
    gzip
  ];
  buildPhase = "";
  installPhase = "sudo make install && sudo make install-manpages";
}
