{ config
, ...
}:

{
  # Make sure our database information gets set up correctly
  services.postgresql = {
    ensureUsers = [
      {
        name = config.services.gitlab.databaseUsername;
        ensureDBOwnership = true;
      }
    ];

    ensureDatabases = [
      config.services.gitlab.databaseName
    ];
  };
}
