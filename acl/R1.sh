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

      ip nat inside source static 100.10.10.1 110.10.10.1
      ip nat inside source static 100.10.10.2 110.10.10.2
      ip nat inside source static 100.10.10.3 110.10.10.3

      int Gig0/0
        ip nat inside
      int Se0/2/0
        ip nat outside
      int Se0/2/1
        ip nat outside
        exit

      ip route 24.10.10.0 255.255.255.252 12.10.10.2
      ip route 34.10.10.0 255.255.255.252 13.10.10.2

      ip route 120.10.10.0 255.255.255.0 12.10.10.2
      ip route 130.10.10.0 255.255.255.0 13.10.10.2
      ip route 140.10.10.0 255.255.255.0 13.10.10.3

      !
      username admin1 secret secret1
      ip domain-name DOMAIN.A
      login on-failure log
      login block-for 30 attempts 3 within 60

      crypto key generate rsa 2048
      ip ssh version 2
      ip ssh time-out 60
      ip ssh authentication-retries 2

      line vty 0 4
        login local
        transport input ssh
        password secret1
        exit

      !
      ip access-list extended PERMIT-ADMIN
        permit tcp 120.10.10.1 0.0.0.0 any eq 22
        permit tcp 130.10.10.1 0.0.0.0 any eq 22
        permit tcp 140.10.10.1 0.0.0.0 any eq 22
      ip access-list extended PERMIT-WEB
        permit tcp any 110.10.10.1 0.0.0.0 eq www
        permit tcp any 110.10.10.1 0.0.0.0 eq 443
      exit

      int Se0/2/1
        ip access-group PERMIT-ADMIN in
        ip access-group PERMIT-WEB in
      int Se0/2/0
        ip access-group PERMIT-ADMIN in
        ip access-group PERMIT-WEB in

    exit

  copy running-config startup-config
    startup-config

  show login
  exit
