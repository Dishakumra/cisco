enable
  conf term
    hostname R2

    int Gig0/0
      ip address 10.10.20.10 255.255.255.0
      no shutdown

    int Se0/2/0
      ip address 10.10.12.2 255.255.255.252
      no shutdown
    int Se0/2/1
      ip address 10.10.24.1 255.255.255.252
      no shutdown
      exit

      ip route 10.10.13.0 255.255.255.252 10.10.12.1
      ip route 10.10.34.0 255.255.255.252 10.10.24.2

    exit

  show ip int brief
  exit
