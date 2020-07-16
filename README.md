# rhouter

Rhouter is a collection of assets that turn a Red Hat Enterprise Linux server into a network router - and more!  Tastes great on beef, PoCs, and homelabs!

***tl;dr: This is basically pfSense, the hard way - with the bonus of being able to run Containers and VMs on your router!***

## Features

Using a few variables, you can easily switch on/off different services such as:

- **Network Routing** (IPv4 and IPv6) (IPv6 is a WIP)
- **DHCP** - dhcpd
- **DNS Forwarding & Resolving** - BIND
- **mDNS** - Avahi
- **NTP** - chrony
- [Always-a-WIP] **Firewall** - firewalld
- [WIP] **Firewall** - fail2ban (uses EPEL, not supported)
- [WIP] **VPN** - OpenVPN
- [WIP] **UPnP** - upnpd

`WIP? That means Work In Progress`

Since this is just a RHEL machine, you can do much more than simply serve network services, like:

- Run Containers with Podman
- Run VMs with oVirt
- ???????
- PROFIT!!!!1

## Assumptions

- This will be deployed to a RHEL 7 machine that is already registered & subscribed
- This RHEL 7 machine is either a physical host or VM with at least 2 NICs, by default 4: WAN, LAN, OPT1, and OPT2

## Issues

- Does not work on RHEL 8 at the moment because of some issues with Ansible expecting different packages for nmcli module

## Quick-start

```bash
cd /opt
git clone github.com/kenmoini/rhouter.git
cd rhouter

./rhel7_init.sh

## Modify variable files as desired, then...

ansible-playbook -i inventory configure.yaml
```

## Tips

### Disable Meltdown/Spectre Mitigations

There's no point to having it running on a router.  Run:

#### RHEL 7
`grubby --args "spectre_v2=off nopti" --update-kernel $(grubby --default-kernel)`

#### RHEL 8
`grubby --args "nospectre_v2 nopti" --update-kernel $(grubby --default-kernel)`

