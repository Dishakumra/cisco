enable
  conf term
    hostname R2

    !
    ip dhcp pool DhcpPool
      network 100.10.20.0 255.255.255.0
      default-router 100.10.20.10

    !
    int Gig0/0
      ip address 100.10.20.10 255.255.255.0
      no shutdown

    int Se0/2/0
      ip address 10.10.22.2 255.255.255.0
      no shutdown
    int Se0/2/1
      ip address 10.10.33.1 255.255.255.0
      no shutdown

    int vlan 22
      ip address 100.10.20.10 255.255.255.0
      no shutdown
      exit

    !
    ip nat pool NatList 100.10.20.0 100.10.20.254 netmask 255.255.255.0
    access-list 22 permit 10.10.20.0 0.255.255.255
    ip nat inside source list 22 pool NatList overload

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
      network 10.0.0.0
      exit

    !
    router bgp 22
    network 10.10.20.0 mask 255.255.255.0
    neighbor 10.10.12.1 remote-as 11

    exit

  copy running-config startup-config
    startup-config
  show ip int brief
  show ip address
  exit
