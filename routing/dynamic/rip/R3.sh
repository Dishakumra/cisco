enable
  conf term
    hostname R3

    ip dhcp pool DhcpPool
      network 100.10.30.0 255.255.255.0
      default-router 100.10.30.10

    int Gig0/0
      ip address 100.10.30.10 255.255.0.0
      no shutdown

    int Se0/2/0
      ip address 10.10.44.1 255.255.255.0
      no shutdown

    int Se0/2/1
      ip address 10.10.11.2 255.255.255.0
      no shutdown
      exit

    ip nat pool NatList 10.10.33.0 10.10.33.254 netmask 255.255.255.0
    access-list 33 permit 10.10.30.0 0.255.255.255
    ip nat inside source list 33 pool NatList overload

    int Gig0/0
      ip nat inside
    int Se0/2/0
      ip nat outside
    int Se0/2/1
      ip nat outside
      exit

    router rip
      version 2
      no auto-summary
      network 10.0.0.0
      exit

    exit

  copy running-config startup-config
    startup-config
  show ip int brief
  show ip address
  exit
