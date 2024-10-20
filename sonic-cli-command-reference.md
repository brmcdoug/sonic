# SONiC CLI Command Reference
## Description: 
This page is a partial SONiC CLI command reference. Expect updates to be added from time to time.
The full SONiC-Net CLI command reference can be found here:
https://github.com/sonic-net/sonic-utilities/blob/master/doc/Command-Reference.md

## Contents
- [SONiC CLI Command Reference](#sonic-cli-command-reference)
  - [Description:](#description)
  - [Contents](#contents)
  - [Global Commands](#global-commands)
    - [show version](#show-version)
    - [Other global commands](#other-global-commands)
  - [Config Management Commands](#config-management-commands)
    - [config load](#config-load)
    - [config save](#config-save)
    - [config reload](#config-reload)
  - [SONiC Docker Container Commands](#sonic-docker-container-commands)
  - [Reload Commands](#reload-commands)
    - [warm reboot](#warm-reboot)
    - [fast reboot](#fast-reboot)
  - [Interface 'show' Commands](#interface-show-commands)
    - [show interfaces description](#show-interfaces-description)
    - [show interfaces status](#show-interfaces-status)
    - [show ip interfaces](#show-ip-interfaces)
    - [show ipv6 interfaces](#show-ipv6-interfaces)
    - [show interfaces portchannel](#show-interfaces-portchannel)
    - [show vlan brief](#show-vlan-brief)
    - [show vlan config](#show-vlan-config)
    - [show lldp table](#show-lldp-table)
    - [show runningconfiguration](#show-runningconfiguration)
  - [Global configuration](#global-configuration)
    - [config hostname](#config-hostname)
  - [Interface configuration](#interface-configuration)
    - [config interface ip add](#config-interface-ip-add)
    - [config interface ip add Loopback](#config-interface-ip-add-loopback)
    - [config portchannel add \[PortChannel#\]](#config-portchannel-add-portchannel)
    - [config portchannel add \[PortChannel#\] \[Ethernet#\]](#config-portchannel-add-portchannel-ethernet)
    - [config interface ip add \[PortChannel#\] \[ip addr\]](#config-interface-ip-add-portchannel-ip-addr)
    - [config vlan add \[vlan#\]](#config-vlan-add-vlan)
    - [config vlan member add \[vlan#\] \[Ethernet#\]](#config-vlan-member-add-vlan-ethernet)
    - [config interface ip add \[Vlan#\] \[ip addr\]](#config-interface-ip-add-vlan-ip-addr)
  
## Global Commands

### show version

Displays the current installed SONiC version as well as Hardware information on the system
```
show version
```

```
SONiC Software Version: SONiC.azure_cisco_202205.5324-dirty-20230707.044127
SONiC OS Version: 11
Distribution: Debian 11.7
Kernel: 5.10.0-18-2-amd64
Build commit: a2dedc96c
Build date: Fri Jul  7 14:22:57 UTC 2023
Built by: sonicci@sonic-ci-7-lnx

Platform: x86_64-8201_32fh_o-r0
HwSKU: 32x400Gb
ASIC: cisco-8000
ASIC Count: 1
Serial Number: FOC2217QGKY
Model Number: 8201-32FH-O
Hardware Revision: 0.33
Uptime: 17:47:47 up 50 min,  1 user,  load average: 0.96, 1.01, 1.03
Date: Fri 18 Aug 2023 17:47:47
```
### Other global commands
```
show processes [cpu | memory | summary]
show system memory
show services
show platform summary
show platform pcieinfo
show runningconfiguration
crm show resources all
```

## Config Management Commands

### config load
Load the */etc/sonic/config_db.json* file into the Redis database
```
config load [-y|--yes] [<filename>]
```

### config save
Save the current system configuration from the Redis database to the */etc/sonic/config_db.json*
```
config save [-y|--yes] [<filename>]
```

### config reload
Clear current configuration and import new configurationn from the input file or from */etc/sonic/config_db.json*
```
config reload [-y|--yes] [-l|--load-sysinfo] [<filename>] [-n|--no-service-restart] [-f|--force]
```

## SONiC Docker Container Commands

SONiC uses a docker container system to manage major functional services. As such common docker commands work:
| CLI                              | Notes                                           |
|:---------------------------------|:------------------------------------------------|
| docker images                    | See image build versions for each container     |
| docker logs <container>          | Review the specifics logs of a container        |
| docker ps                        | Lists the subsystem containers running          |
| docker restart <container>       | Restarts a specific container                   |
| docker stats                     | Shows resource consumption by each container    |


## Reload Commands

### warm reboot
The goal of SONiC warm reboot is to be able restart and upgrade SONiC software without impacting the data plane. Warm restart of each individual process/docker is also part of the goal. Except for syncd and database docker, it is desired for all other network applications and dockers to support un-planned warm restart.
  - Warm-Reboot must not impact the data plane.

```
sudo warm-reboot
```

### fast reboot
Fast-reboot feature enables a switch to reboot up quickly, with minimum disruption to the data plane.
  - Fast-Reboot must disrupt data plane not more than 25 seconds
  - Fast-Reboot must disrupt control plane not more than 90 seconds
    
```
sudo fast-reboot
```

## Interface 'show' Commands

### show interfaces description
Similar to Cisco 'show interface brief'
```
show interfaces description
```

### show interfaces status
More detail on interfaces
```
show interfaces status
```

### show ip interfaces
Show interfaces and their IP addresses
```
show ip interfaces
```

### show ipv6 interfaces
Show interfaces and their IPv6 addresses
```
show ipv6 interfaces
```

### show interfaces portchannel
Show portchannel information
```
show interfaces portchannel
```

### show vlan brief
Show summary of system vlan information
```
show vlan brief
```

### show vlan config
Show summary of system vlan configuration
```
show vlan config
```

### show lldp table
Provides lldp neighbor adjacency info
```
show lldp table
```

### show runningconfiguration 
Show various aspects of the running configuration
```
show runningconfiguration all
show runningconfiguration bgp
show runningconfiguration interfaces
etc.
```

## Global configuration

### config hostname
Add or modify the node hostname
```
sudo config hostname [hostname]
```

## Interface configuration

### config interface ip add
Adding an IP address to an interface
```
sudo config interface ip add Ethernet0 10.1.1.1/31
sudo config interface ip add Ethernet0 fc00:0::1/127
```

### config interface ip add Loopback
Adding a loopback interface and IP
```
sudo config interface ip add Loopback0 10.0.0.1/32
sudo config interface ip add Loopback0 fc00:0:1::1/128

sudo config interface ip add Loopback1 10.0.1.1/32
```

### config portchannel add [PortChannel#]
Adding a portchannel
```
sudo config portchannel add PortChannel1
```

### config portchannel add [PortChannel#] [Ethernet#]
Add an interface as a portchannel member
```
sudo config portchannel member add PortChannel1 Ethernet8
sudo config portchannel member add PortChannel1 Ethernet12
```

### config interface ip add [PortChannel#] [ip addr]
Adding IP addresses to portchannel interfaces
```
sudo config interface ip add PortChannel1 10.1.1.0/31
sudo config interface ip add PortChannel1 fc00:0:ffff::/127
```

### config vlan add [vlan#]
Adding a vlan
```
sudo config vlan add 10
```

### config vlan member add [vlan#] [Ethernet#]
Add an interface as a vlan member or access port
```
sudo config vlan member add 10 Ethernet28
sudo config vlan member add 10 Ethernet32
```

### config interface ip add [Vlan#] [ip addr]
Configure vlan IP addresses
```
sudo config interface ip add Vlan10 10.10.1.1/24
sudo config interface ip add Vlan10 fc00:0:ffff:10::1/64
```