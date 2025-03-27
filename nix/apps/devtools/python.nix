{ pkgs
, ...
}:
{
  environment.systemPackages = with pkgs; [
    (pkgs.python312.withPackages (ps: with ps; [
      pip
      env
      jupyterlab
    ]))
    pyright
    ruff
  ];
}

