# rhouter

Rhouter is a collection of assets that turn a Red Hat Enterprise Linux server into a network router - and more!  Tastes great on beef, PoCs, and homelabs!

## Features

Using a few variables, you can easily switch on/off different services such as:

- Network Routing (IPv4 and IPv6)
- DHCP (dhcpd)
- DNS Resolving (BIND)
- mDNS (Avahi)
- NTP (chrony)
- VPN (OpenVPN)
- Firewall (firewalld)
- Firewall (fail2ban, uses EPEL, not supported)
- UPnP (upnpd)


## Tips

### Disable Meltdown/Spectre Mitigations

There's no point to having it running on a router.  Run:

#### RHEL 7
`grubby --args "spectre_v2=off nopti" --update-kernel $(grubby --default-kernel)`

#### RHEL 8
`grubby --args "nospectre_v2 nopti" --update-kernel $(grubby --default-kernel)`