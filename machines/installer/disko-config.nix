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
              name = "nix-esp";
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
              name = "nix-root";
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [
                  "-f"
                  "-O"
                  "no-holes"
                  "-R"
                  "free-space-tree"
                  "-s"
                  "4096"
                  "-n"
                  "4096"
                ];
                subvolumes = {
                  "/@" = {
                    mountpoint = "/";
                    mountOptions = [
                      "compress=zstd:3"
                      "noatime"
                      "ssd"
                      "space_cache=v2"
                      "commit=120"
                      "discard=async"
                    ];
                  };
                  "/@home" = {
                    mountpoint = "/home";
                    mountOptions = [
                      "compress=zstd:3"
                      "noatime"
                      "ssd"
                      "space_cache=v2"
                      "commit=120"
                      "discard=async"
                      "autodefrag"
                    ];
                  };
                  "/@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress=zstd:1"
                      "noatime"
                      "ssd"
                      "space_cache=v2"
                      "commit=300"
                      "discard=async"
                    ];
                  };
                  "/@log" = {
                    mountpoint = "/var/log";
                    mountOptions = [
                      "compress=zstd:6"
                      "noatime"
                      "ssd"
                      "space_cache=v2"
                      "commit=300"
                      "discard=async"
                      "autodefrag"
                    ];
                  };
                  "/@tmp" = {
                    mountpoint = "/tmp";
                    mountOptions = [
                      "compress=no"
                      "noatime"
                      "ssd"
                      "space_cache=v2"
                      "nosuid"
                      "nodev"
                      "discard=async"
                    ];
                  };
                  "/@var" = {
                    mountpoint = "/var";
                    mountOptions = [
                      "compress=zstd:3"
                      "noatime"
                      "ssd"
                      "space_cache=v2"
                      "commit=300"
                      "discard=async"
                      "autodefrag"
                    ];
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