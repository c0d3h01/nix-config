{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      # Core fonts
      dejavu_fonts
      noto-fonts
      noto-fonts-color-emoji

      # Monospace/coding fonts
      jetbrains-mono
      nerd-fonts.jetbrains-mono

      # UI fonts
      inter
    ];

    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        style = "slight";
      };
      subpixel.rgba = "rgb";

      defaultFonts = {
        sansSerif = ["Inter" "DejaVu Sans"];
        serif = ["DejaVu Serif"];
        monospace = ["JetBrains Mono" "DejaVu Sans Mono"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
