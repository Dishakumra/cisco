enable
  conf term
    hostname R1

    !
    ip dhcp pool DhcpPool
      network 100.10.10.0 255.255.255.0
      default-router 100.10.10.10

    !
    int Gig0/0
      ip address 100.10.10.10 255.255.255.0
      no shutdown

    int Gig0/1
      ip address 120.10.10.10 255.255.255.0
      no shutdown

    int Se0/2/0
      ip address 12.10.10.1 255.255.255.252
      no shutdown

    int Se0/2/1
      ip address 13.10.10.1 255.255.255.252
      no shutdown
      exit

    !
    ip nat pool NatList 120.10.10.0 120.10.10.254 netmask 255.255.255.0
    access-list 11 permit 100.10.10.0 0.0.0.255
    ip nat inside source list 11 pool NatList overload

    int Gig0/0
      ip nat inside
    int Se0/2/0
      ip nat outside
    int Se0/2/1
      ip nat outside
      exit

    !
    router rip
      version 2
      no auto-summary
      network 12.0.0.0
      network 24.0.0.0
      network 120.0.0.0
      exit

    exit

  copy running-config startup-config
    startup-config
  show ip int brief
  show ip address
  exit
