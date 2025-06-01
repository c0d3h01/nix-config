{ pkgs, ... }:
{
  services = {
    postgresql = {
      enable = true;
      enableJIT = true;
      package = pkgs.postgresql_17;
      settings.shared_preload_libraries = "pg_stat_statements";
    };

    prometheus.exporters.postgres = {
      enable = true;
      port = 9003;
      runAsLocalSuperUser = true;
      extraFlags = [
        "--auto-discover-databases"
        "--collector.long_running_transactions"
        "--collector.stat_activity_autovacuum"
        "--collector.stat_statements"
      ];
    };

    pgscv = {
      enable = true;
      logLevel = "debug";
      settings = {
        services.postgres = {
          service_type = "postgres";
          conninfo = "postgres://";
        };
      };
    };
  };

  environment.etc."alloy/postgres.alloy".source = ./postgres.alloy;
}
