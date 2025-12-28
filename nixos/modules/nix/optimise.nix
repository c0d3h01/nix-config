{pkgs, ...}: {
  nix = {
    # Automatic store GC
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    # Periodic hard‑link dedup
    optimise.automatic = true;
  };
}
