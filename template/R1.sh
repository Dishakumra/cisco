enable
  conf term
    hostname R1

    int Gig0/0
      ip address 100.10.10.10 255.255.255.0
      no shutdown

    int Se0/2/0
      ip address 12.10.10.1 255.255.255.252
      no shutdown

    int Se0/2/1
      ip address 13.10.10.1 255.255.255.252
      no shutdown
      exit

    exit

  copy running-config startup-config
    startup-config
  show ip int brief
  show ip address
  show ip nat translations
  exit
