{
  pkgs,
  config,
  lib,
  userConfig,
  ...
}:
{
  config = lib.mkIf userConfig.devStack.db {
    sops.secrets = {
      mysql_user = { };
      mysql_password = { };
      mysql_root_password = { };
    };

    services.mysql = {
      enable = true;
      package = pkgs.mariadb;
      ensureDatabases = [ "development" ];
      ensureUsers = [
        {
          name = userConfig.username;
          ensurePermissions = {
            "development.*" = "ALL PRIVILEGES";
          };
        }
      ];
      settings = {
        mysqld = {
          bind_address = "127.0.0.1";
          innodb_buffer_pool_size = "256M";
          slow_query_log = 1;
          slow_query_log_file = "/var/log/mysql/slow.log";
        };
      };
    };

    environment.systemPackages = with pkgs; [
      mysql-workbench
      mariadb-client
      mycli
    ];
  };
}
