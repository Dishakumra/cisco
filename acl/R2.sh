enable
  conf term
    hostname R2

    int Gig0/0
      ip address 100.10.10.10 255.255.255.0
      no shutdown

    int Se0/2/0
      ip address 12.10.10.2 255.255.255.252
      no shutdown
    int Se0/2/1
      ip address 24.10.10.1 255.255.255.252
      no shutdown
      exit

      ip nat inside source static 100.10.10.1 120.10.10.1
      ip nat inside source static 100.10.10.2 120.10.10.2
      ip nat inside source static 100.10.10.3 120.10.10.3

      int Gig0/0
        ip nat inside
      int Se0/2/0
        ip nat outside
      int Se0/2/1
        ip nat outside
        exit

      ip route 13.10.10.0 255.255.255.252 12.10.10.1
      ip route 34.10.10.0 255.255.255.252 24.10.10.2

      ip route 110.10.10.0 255.255.255.0 12.10.10.1
      ip route 130.10.10.0 255.255.255.0 12.10.10.1
      ip route 140.10.10.0 255.255.255.0 24.10.10.2
    exit

  copy running-config startup-config
    startup-config
  show ip int brief
  show ip address
  exit
