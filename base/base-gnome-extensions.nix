{ pkgs, config, libs, inputs, ... }: {
  
  home.packages = with pkgs.gnomeExtensions; [
    alphabetical-app-grid
    appindicator
    blur-my-shell
    burn-my-windows
    caffeine
    dash2dock-lite
    gsconnect
    logo-menu
    night-theme-switcher
    pop-shell
    quick-settings-audio-devices-renamer
    search-light
    wifi-qrcode
    wiggle
    window-title-is-back
    xwayland-indicator
    zen
  ];
}
