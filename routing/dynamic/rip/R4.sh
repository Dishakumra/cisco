enable
  conf term
    hostname R4

    ip dhcp pool DhcpPool
      network 10.10.40.0 255.255.255.0
      default-router 10.10.40.10

    int Gig0/0
      no ip address 169.254.0.1 255.255.0.0
      ip address 10.10.40.10 255.255.0.0
      no shutdown

    int Se0/2/0
      ip address 10.10.34.2 255.255.255.252
      no shutdown
    int Se0/2/1
      ip address 10.10.24.2 255.255.255.252
      no shutdown
      exit

    router rip
      version 2
      no auto-summary
      network 169.254.0.0
      network 10.10.24.0
      network 10.10.34.0
      exit

      int Gig0/0
        ip nat inside
      int Se0/2/0
        ip nat outside
      int Se0/2/1
        ip nat outside
        exit

    exit

  copy running-config startup-config
    startup-config
  show ip int brief
  show ip address
  exit
