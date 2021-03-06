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
- **System** - Cockpit Dashboard
- **System** - Containers with Buildah, Podman, and Skopeo
- **System** - SSHd Configuration and Security
- [WIP] **DHCP** - dhcpd6
- [Always-a-WIP] **Firewall** - firewalld
- [WIP] **Firewall** - fail2ban (uses EPEL)
- [WIP] **VPN** - OpenVPN (uses EPEL)
- [WIP] **VPN** - Wireguard (uses EPEL and EL Repo)
- [WIP] **UPnP** - upnpd
- [WIP] **Monitoring** - ntop/ntopng
- [WIP] **Monitoring** - Snort
- [WIP] **System** - apcupsd
- [WIP] **Proxy** - Squid

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

cp extra_vars.yaml.example extra_vars.yaml

## Modify variable files as desired, then...

ansible-playbook -i inventory -e @extra_vars.yaml configure.yaml
```

## Tips

### Available Playbook Tags

Some things take time and can be skipped if you already know the state of the system.  This is a list of available tags to use with `--skip-tags tag1,tag2,tagN` (listed in order of execution)

1. setHostname
2. systemUpdate
3. configureInterfaces
    1. installPackages && installNetworkManager
4. configureFirewall && configureFirewalld
    1. installPackages && installFirewalld
5. configureRouting
6. configureCockpit
    1. configureRepos && configureRHEL7ExtrasRepo && configureRHEL7OptionRepo
    2. installPackages && installCockpit
7. configureContainers
    1. configureRepos && configureRHEL7ExtrasRepo
    2. installPackages && installContainers
    3. podmanAuthToRHRegistry
8. configureFirewall && configureFail2ban
    1. installEPEL
    2. installPackages && installFail2ban
9. configureDNS && configureBIND
    1. installPackages && installBIND
10. configuremDNS && configureAvahi
    1. installPackages && installAvahi
11. configureDHCP && configureDHCPd
    1. installPackages && installDHCPd
12. configureNTP && configureChronyd
    1. installPackages && installChrony
    2. setTimezone
    3. setSystemToNTPSync
13. configureSSHd
14. configureVPN && configureOpenVPN
    1. installPackages && installOpenVPN
    2. installPackages && installNginx

### Disable Meltdown/Spectre Mitigations

There's no point to having it running on a router.  Run:

#### RHEL 7
`grubby --args "spectre_v2=off nopti" --update-kernel $(grubby --default-kernel)`

#### RHEL 8
`grubby --args "nospectre_v2 nopti" --update-kernel $(grubby --default-kernel)`

