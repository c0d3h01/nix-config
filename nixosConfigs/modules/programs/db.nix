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
      initialDatabases = [
        {
          name = "development";
          schema = ./schema.sql;
        }
      ];
      initialScript = pkgs.writeText "init.sql" ''
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${config.sops.secrets.mysql_root_password.path}';
        CREATE DATABASE IF NOT EXISTS development
        CHARACTER SET utf8mb4
        COLLATE utf8mb4_unicode_ci;
        CREATE USER IF NOT EXISTS '${config.sops.secrets.mysql_user.path}'@'localhost'
        IDENTIFIED BY '${config.sops.secrets.mysql_password.path}';
        GRANT ALL PRIVILEGES ON development.* TO '${config.sops.secrets.mysql_user.path}'@'localhost';
        FLUSH PRIVILEGES;
      '';
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
