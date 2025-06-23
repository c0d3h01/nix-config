{
  disko.devices = {
    disk = {
      nvme = {
        device = "/dev/nvme0n1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "/@" = {
                    mountpoint = "/";
                    mountOptions = [
                      "compress=zstd:1"
                      "ssd"
                      "noatime"
                      "lazytime"
                      "space_cache=v2"
                      "commit=120"
                      "nodiscard"
                    ];
                  };
                  "/@home" = {
                    mountpoint = "/home";
                    mountOptions = [
                      "compress=zstd:1"
                      "ssd"
                      "noatime"
                      "lazytime"
                      "space_cache=v2"
                      "commit=120"
                      "nodiscard"
                    ];
                  };
                  "/@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress=zstd:1"
                      "ssd"
                      "noatime"
                      "space_cache=v2"
                      "commit=60"
                      "nodiscard"
                    ];
                  };
                #   "/@log" = {
                #     mountpoint = "/var/log";
                #     mountOptions = [
                #       "compress=zstd:1"
                #       "ssd"
                #       "noatime"
                #       "space_cache=v2"
                #       "commit=120"
                #       "nodiscard"
                #     ];
                #   };
                #   "/@tmp" = {
                #     mountpoint = "/tmp";
                #     mountOptions = [
                #       "ssd"
                #       "noatime"
                #       "space_cache=v2"
                #       "nodatacow"
                #       "commit=120"
                #       "nodiscard"
                #     ];
                #   };
                };
              };
            };
          };
        };
      };
    };
  };
}
