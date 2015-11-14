enable
  conf term
    hostname R1

    !
    ip dhcp pool DhcpPool
      network 10.10.10.0 255.255.255.0
      default-router 10.10.10.10

    !
    int Gig0/0
      ip address 10.10.10.10 255.255.255.0
      no shutdown

    int Se0/2/0
      ip address 10.10.12.1 255.255.255.0
      no shutdown

    int Se0/2/1
      ip address 10.10.13.1 255.255.255.0
      no shutdown

    int vlan 11
      ip address 10.10.11.10 255.255.255.0
      no shutdown
      exit

    !
    ip nat pool NatList 10.10.11.0 10.10.11.254 netmask 255.255.255.0
    access-list 11 permit 10.10.10.0 0.255.255.255
    ip nat inside source list 11 pool NatList overload

    int Gig0/0
      ip nat inside
    int Se0/2/0
      ip nat outside
    int Se0/2/1
      ip nat outside
      exit

    !
    int Gig0/0
    router rip
      version 2
      no auto-summary
      network 10.0.0.0
      exit

    !
    router bgp 11
    network 10.10.10.0 mask 255.255.255.0
    neighbor 10.10.12.2 remote-as 22

    exit

  copy running-config startup-config
    startup-config
  show ip int brief
  show ip address
  show ip nat translations
  exit
