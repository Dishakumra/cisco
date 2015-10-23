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
    exit
  
  copy running-config startup-config
    startup-config
  show ip int brief
  exit
