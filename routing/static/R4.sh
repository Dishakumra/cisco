enable
  conf term
    hostname R4

    int Gig0/0
      ip address 10.10.40.10 255.255.255.0
      no shutdown

    int Se0/2/0
      ip address 10.10.34.2 255.255.255.252
      no shutdown
    int Se0/2/1
      ip address 10.10.24.2 255.255.255.252
      no shutdown
      exit

      ip route 10.10.12.0 255.255.255.252 10.10.24.1
      ip route 10.10.13.0 255.255.255.252 10.10.34.1
      
    exit

  copy running-config startup-config
    startup-config
  show ip int brief
  show ip address
  exit
