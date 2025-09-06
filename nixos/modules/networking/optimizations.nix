{
  boot.kernelModules = [
    "tcp_bbr"
  ];

  boot.kernel.sysctl = {
    # Security / Hygiene
    "net.ipv4.icmp_ignore_bogus_error_responses" = 1; # Drop malformed ICMP noise
    "net.ipv4.conf.all.accept_source_route" = 0; # Disallow IP source routing (IPv4)
    "net.ipv4.conf.default.accept_source_route" = 0;
    "net.ipv6.conf.all.accept_source_route" = 0; # Disallow IP source routing (IPv6)
    "net.ipv4.conf.all.accept_redirects" = 0; # Ignore ICMP redirects (prevent MITM)
    "net.ipv4.conf.default.accept_redirects" = 0;
    "net.ipv4.conf.all.secure_redirects" = 0; # Treat “secure” redirects same (ignore)
    "net.ipv4.conf.default.secure_redirects" = 0;
    "net.ipv6.conf.all.accept_redirects" = 0; # Ignore IPv6 redirects
    "net.ipv6.conf.default.accept_redirects" = 0;
    "net.ipv4.tcp_syncookies" = 1; # SYN flood protection
    "net.ipv4.tcp_rfc1337" = 1; # Protect TIME-WAIT sockets
    "net.ipv4.conf.all.rp_filter" = 1; # Strict reverse path filter (IPv4)
    "net.ipv4.conf.default.rp_filter" = 1;

    # Performance / Latency
    "net.ipv4.tcp_congestion_control" = "bbr"; # Modern low-latency CC
    "net.core.default_qdisc" = "fq"; # Fair queue for pacing (works well with BBR)
    "net.ipv4.tcp_mtu_probing" = 1; # Probe MTU on blackhole detection
    "net.core.somaxconn" = 4096; # Larger listen backlog for local services
    "net.ipv4.ip_local_port_range" = "16384 65535"; # Wider ephemeral port range
    "net.core.netdev_max_backlog" = 4096; # Reasonable NIC packet queue limit

    # Socket Buffers (moderate ceilings)
    "net.core.rmem_max" = 8388608; # Max receive buffer (8 MiB)
    "net.core.wmem_max" = 8388608; # Max send buffer (8 MiB)
    "net.ipv4.tcp_rmem" = "4096 87380 8388608"; # Min / default / max recv autotune
    "net.ipv4.tcp_wmem" = "4096 65536 8388608"; # Min / default / max send autotune
  };
}
