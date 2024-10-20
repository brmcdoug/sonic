## Two Tier Small CLOS
Instructions to deploy and work with the 2-tier small clos project

### Contents
- [Two Tier Small CLOS](#two-tier-small-clos)
  - [Contents](#contents)
  - [Ansible deploy script](#ansible-deploy-script)
  - [Verify nodes and interfaces](#verify-nodes-and-interfaces)
    - [Management IP table](#management-ip-table)
  - [SONiC FRR vtysh](#sonic-frr-vtysh)
- [Configure sonic-rtr-leaf-1 with SONiC CLI](#configure-sonic-rtr-leaf-1-with-sonic-cli)

Topology:
<img src="/diagrams/sonic-vs-2-tier-small-clos.png" width="800">

### Ansible deploy script

1. On your host or VM *`cd`* into your chosen project directory, then into its ansible sub-directory. Example: 
```
cd 1-two-tier-small-clos/ansible/
```

2. Determine whether you would like to deploy using *`IP/BGP numbered or unnumbered`*. The scripts default to unnumbered. If you wish to run *`IP/BGP numbered`* edit the following lines in the deploy script:

[Line 1](./ansible/deploy-small-clos.yaml#L61)

[Line 2](./ansible/deploy-small-clos.yaml#L78)

3. Run the ansible deploy script. Note, the script will launch and configure three of the spine nodes and one of the leaf nodes, leaving sonic01 and sonic03 unconfigured. This guide will walk thru configuring them via the SONiC CLI
   
   Note: adjust user/pw credentials as needed. The script will take about 3 minutes to run.
   ```
   cd ansible
   ansible-playbook -i hosts deploy-small-clos.yaml -e "ansible_user=cisco ansible_ssh_pass=cisco123 ansible_sudo_pass=cisco123" -vv
   ```

### Verify nodes and interfaces

1. Once the script completes the sonic-vs nodes should all be up and running using the configurations found in the chosen config directory. Example [config-unnumbered](./config-unnumbered/) 

   * If you are running the deploy script for the first time please proceed. If you've already run it and wish to make changes then re-run the script, please run the "destroy" script first

   ```
   ansible-playbook -i hosts destroy-small-clos.yaml -e "ansible_user=cisco ansible_ssh_pass=cisco123 ansible_sudo_pass=cisco123" -vv
   ```
  * Note: the deploy script will automatically assign management IPs to each node per the [kvm-mgt-net.xml](./kvm/mgt-net.xml) file

#### Management IP table

| SONiC VS Node  | Mgt Ip             |
|:---------------|:-------------------|
| sonic01        | 192.168.122.101    |
| sonic02        | 192.168.122.102    |
| sonic03        | 192.168.122.103    |
| sonic04        | 192.168.122.104    |
| sonic05        | 192.168.122.105    |
| sonic06        | 192.168.122.106    |

2. Noting that sonic01 and sonic03 have not been configured yet, ssh to each of the other nodes and check interface and IP status. Example:

```
ssh cisco@192.168.122.102

show interfaces status
show ip interfaces 
```

Example output:
```
cisco@sonic02:~$ show interfaces status
  Interface                Lanes    Speed    MTU    FEC        Alias    Vlan    Oper    Admin    Type    Asym PFC
-----------  -------------------  -------  -----  -----  -----------  ------  ------  -------  ------  ----------
  Ethernet0  2304,2305,2306,2307     100G   9100    N/A    Ethernet0  routed      up       up     N/A         N/A
  Ethernet4  2320,2321,2322,2323     100G   9100    N/A    Ethernet4  routed      up       up     N/A         N/A
  Ethernet8  2312,2313,2314,2315     100G   9100    N/A    Ethernet8  routed      up       up     N/A         N/A
 Ethernet12  2056,2057,2058,2059     100G   9100    N/A   Ethernet12  routed      up       up     N/A         N/A
 Ethernet16  1792,1793,1794,1795     100G   9100    N/A   Ethernet16  routed      up       up     N/A         N/A
 Ethernet20  2048,2049,2050,2051     100G   9100    N/A   Ethernet20  routed      up       up     N/A         N/A
 Ethernet24  2560,2561,2562,2563     100G   9100    N/A   Ethernet24  routed      up       up     N/A         N/A
 Ethernet28  2824,2825,2826,2827     100G   9100    N/A   Ethernet28  routed      up       up     N/A         N/A
 Ethernet32  2832,2833,2834,2835     100G   9100    N/A   Ethernet32  routed      up       up     N/A         N/A
 Ethernet36  2816,2817,2818,2819     100G   9100    N/A   Ethernet36  routed      up       up     N/A         N/A
 Ethernet40  2568,2569,2570,2571     100G   9100    N/A   Ethernet40  routed      up       up     N/A         N/A
 Ethernet44  2576,2577,2578,2579     100G   9100    N/A   Ethernet44  routed      up       up     N/A         N/A
 Ethernet48  1536,1537,1538,1539     100G   9100    N/A   Ethernet48  routed      up       up     N/A         N/A
 Ethernet52  1800,1801,1802,1803     100G   9100    N/A   Ethernet52  routed      up       up     N/A         N/A
 Ethernet56  1552,1553,1554,1555     100G   9100    N/A   Ethernet56  routed      up       up     N/A         N/A
 Ethernet60  1544,1545,1546,1547     100G   9100    N/A   Ethernet60  routed      up       up     N/A         N/A
 Ethernet64  1296,1297,1298,1299     100G   9100    N/A   Ethernet64  routed      up       up     N/A         N/A
 Ethernet68  1288,1289,1290,1291     100G   9100    N/A   Ethernet68  routed      up       up     N/A         N/A
 Ethernet72  1280,1281,1282,1283     100G   9100    N/A   Ethernet72  routed      up       up     N/A         N/A
 Ethernet76  1032,1033,1034,1035     100G   9100    N/A   Ethernet76  routed      up       up     N/A         N/A
 Ethernet80      264,265,266,267     100G   9100    N/A   Ethernet80  routed      up       up     N/A         N/A
 Ethernet84      272,273,274,275     100G   9100    N/A   Ethernet84  routed      up       up     N/A         N/A
 Ethernet88          16,17,18,19     100G   9100    N/A   Ethernet88  routed      up       up     N/A         N/A
 Ethernet92              0,1,2,3     100G   9100    N/A   Ethernet92  routed      up       up     N/A         N/A
 Ethernet96      256,257,258,259     100G   9100    N/A   Ethernet96  routed      up       up     N/A         N/A
Ethernet100            8,9,10,11     100G   9100    N/A  Ethernet100  routed      up       up     N/A         N/A
Ethernet104  1024,1025,1026,1027     100G   9100    N/A  Ethernet104  routed      up       up     N/A         N/A
Ethernet108      768,769,770,771     100G   9100    N/A  Ethernet108  routed      up       up     N/A         N/A
Ethernet112      524,525,526,527     100G   9100    N/A  Ethernet112  routed      up       up     N/A         N/A
Ethernet116      776,777,778,779     100G   9100    N/A  Ethernet116  routed      up       up     N/A         N/A
Ethernet120      516,517,518,519     100G   9100    N/A  Ethernet120  routed      up       up     N/A         N/A
Ethernet124      528,529,530,531     100G   9100    N/A  Ethernet124  routed      up       up     N/A         N/A
cisco@sonic02:~$ 
cisco@sonic02:~$ show ip interfaces
Interface    Master    IPv4 address/mask    Admin/Oper    BGP Neighbor    Neighbor IP
-----------  --------  -------------------  ------------  --------------  -------------
Ethernet16   Vrf1      10.101.1.1/24        up/up         N/A             N/A
Ethernet20   Vrf2      10.102.1.1/24        up/up         N/A             N/A
Loopback0              10.0.0.1/32          up/up         N/A             N/A
docker0                240.127.1.1/24       up/down       N/A             N/A
eth0                   192.168.122.101/24   up/up         N/A             N/A
lo                     127.0.0.1/16         up/up         N/A             N/A
```

### SONiC FRR vtysh
Per https://github.com/sonic-net/sonic-frr/blob/master/doc/user/vtysh.rst
vtysh provides a combined frontend to all FRR daemons in a single combined session.

1. Ssh into sonic02 then invoke vtysh to access FRR
```
ssh cisco@192.168.122.102
```
```
vtysh
```

Example:
```
cisco@sonic02:~$ vtysh

Hello, this is FRRouting (version 8.5.1).
Copyright 1996-2005 Kunihiro Ishiguro, et al.

sonic02# 
```

2. Run some FRR CLI commands:
```
show run
show int brief
show bgp summary
show bgp ipv4 unicast 
show bgp ipv6 unicast 
ping fc00:0:3::1
```

## Configure sonic-rtr-leaf-1 with SONiC CLI

1. Log into SONiC router *sonic-rtr-leaf-1*
   ```
   ssh cisco@192.168.122.101
   ssh cisco@leaf-1
   ```
2. Configure *Loopback0* and add IPv4 and IPv6
   ```
   sudo config interface ip add Loopback0 10.0.0.1/32
   sudo config interface ip add Loopback0 fc00:0:1::1/128
   ```
3. Configure Ethernet interface from *sonic-rtr-leaf-1* to *endpoint01*
   ```
   sudo config interface ip add Ethernet16 198.18.11.1/24
   ```
4. Create Port Channels to *sonic-rtr-spine-1* and *sonic-rtr-spine-2*
   ```
   sudo config portchannel add PortChannel1
   sudo config portchannel add PortChannel2
   ```
5.  Configure Port Channel interface members
    ```
    sudo config portchannel member add PortChannel1 Ethernet0
    sudo config portchannel member add PortChannel1 Ethernet4
    sudo config portchannel member add PortChannel2 Ethernet8
    sudo config portchannel member add PortChannel2 Ethernet12
    ```
6. Configure Port Channel IPs
   ```
   sudo config interface ip add PortChannel1 10.1.1.0/31
   sudo config interface ip add PortChannel2 10.1.1.2/31
   sudo config interface ip add PortChannel1 fc00:0:ffff::/127
   sudo config interface ip add PortChannel2 fc00:0:ffff::2/127
   ```

7. Save configuration
   ```
   sudo config save
   ```
