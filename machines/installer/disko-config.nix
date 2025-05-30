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
              priority = 1;
              name = "nix-esp";
              start = "1MiB";
              end = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              name = "nix-root";
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" "-O" "no-holes" "-R" "free-space-tree" ];
                subvolumes = {
                  "/@" = {
                    mountpoint = "/";
                    mountOptions = [
                      "compress=zstd:3"
                      "discard=async"
                      "noatime"
                      "ssd"
                      "space_cache=v2"
                      "autodefrag"
                      "commit=120"
                    ];
                  };
                  "/@home" = {
                    mountpoint = "/home";
                    mountOptions = [
                      "compress=zstd:3"
                      "discard=async"
                      "noatime"
                      "ssd"
                      "space_cache=v2"
                      "autodefrag"
                      "commit=120"
                    ];
                  };
                  "/@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress=zstd:1"
                      "discard=async"
                      "noatime"
                      "ssd"
                      "space_cache=v2"
                      "commit=300"
                    ];
                  };
                  "/@log" = {
                    mountpoint = "/var/log";
                    mountOptions = [
                      "compress=zstd:6"
                      "discard=async"
                      "noatime"
                      "ssd"
                      "space_cache=v2"
                      "commit=300"
                    ];
                  };
                  "/@tmp" = {
                    mountpoint = "/tmp";
                    mountOptions = [
                      "compress=no"
                      "discard=async"
                      "noatime"
                      "ssd"
                      "space_cache=v2"
                      "nosuid"
                      "nodev"
                    ];
                  };
                  "/@var" = {
                    mountpoint = "/var";
                    mountOptions = [
                      "compress=zstd:3"
                      "discard=async"
                      "noatime"
                      "ssd"
                      "space_cache=v2"
                      "autodefrag"
                      "commit=300"
                    ];
                  };
                  "/@swap" = {
                    mountpoint = "/swap";
                    swap = {
                      swapfile.size = "4G";
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}