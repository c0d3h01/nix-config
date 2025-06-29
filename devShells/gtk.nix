{
    pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
    name = "GTK Shell";
    buildInputs = with pkgs; [
      gtk4
      glib
      pango
      gdk-pixbuf
      gobject-introspection
      libepoxy
    ];
}
