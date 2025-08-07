{
  pkgs,
  lib,
  config,
  ...
}:
{
  # Run dynamically linked librarys.
  programs.nix-ld = {
    enable = true;
    libraries =
      with pkgs;
      [
        openssl
        curl
        glibc
        libsecret
        sdl3
        acl
        attr
        bzip2
        dbus
        expat
        fontconfig
        freetype
        fuse3
        icu
        libnotify
        libsodium
        libssh
        libunwind
        libusb1
        libuuid
        libsodium
        libxml2
        nspr
        nss
        stdenv.cc.cc
        util-linux
        systemd
        zlib
        xz
        cargo
        zstd
      ]
      ++ lib.optionals config.hardware.graphics.enable [
        pipewire
        cups
        libxkbcommon
        pango
        mesa
        libdrm
        libglvnd
        libpulseaudio
        atk
        cairo
        alsa-lib
        at-spi2-atk
        at-spi2-core
        gdk-pixbuf
        glib
        gtk3
        libGL
        libappindicator-gtk3
        vulkan-loader
      ];
  };
}
