enable
  conf term
    hostname R1

    int Gig0/0
      ip address 10.10.10.10 255.255.255.0
      no shutdown

    int Se0/2/0
      ip address 10.10.12.1 255.255.255.252
      no shutdown
    int Se0/2/1
      ip address 10.10.13.1 255.255.255.252
      no shutdown
      exit
    exit

  show ip int brief
  exit
