## Two Tier Small CLOS
Instructions to deploy and work with the 2-tier small clos project

### Contents
- [Two Tier Small CLOS](#two-tier-small-clos)
  - [Contents](#contents)
  - [Ansible deploy script](#ansible-deploy-script)
  - [Verify nodes](#verify-nodes)

Topology:
<img src="/diagrams/sonic-vs-2-tier-small-clos.png" width="1200">

### Ansible deploy script

1. On your host or VM cd into your chosen project directory, then into its ansible sub-directory. Example: 
```
cd 1-two-tier-small-clos/ansible/
```

2. Determine whether you would like to deploy using *`IP/BGP numbered or unnumbered`*. The scripts default to unnumbered. If you wish to run *`IP/BGP numbered`* edit the following lines in the deploy script:

[Line 1](./ansible/deploy-small-clos.yaml#L61)
[Line 2](./ansible/deploy-small-clos.yaml#L78)

3. Run the ansible deploy script
   
   Note: adjust user/pw credentials as needed. The script will take about 3 minutes to run.
   ```
   cd ansible
   ansible-playbook -i hosts deploy-small-clos.yaml -e "ansible_user=cisco ansible_ssh_pass=cisco123 ansible_sudo_pass=cisco123" -vv
   ```

4. Once the script completes the sonic-vs nodes should all be up and running using the configurations found in the chosen config directory. Example [config-unnumbered](./config-unnumbered/) 

   * If you are running the deploy script for the first time please proceed. If you've already run it and wish to make changes then re-run the script, please run the "destroy" script first

   ```
   ansible-playbook -i hosts destroy-small-clos.yaml -e "ansible_user=cisco ansible_ssh_pass=cisco123 ansible_sudo_pass=cisco123" -vv
   ```
  * Note: the deploy script will automatically assign management IPs to each node per the [kvm-mgt-net.xml](./kvm/mgt-net.xml) file

### Verify nodes

| SONiC VS Node  | Mgt Ip             |
|:---------------|:-------------------|
| sonic01        | 192.168.122.101    |
| sonic02        | 192.168.122.102    |
| sonic03        | 192.168.122.103    |
| sonic04        | 192.168.122.104    |
| sonic05        | 192.168.122.105    |
| sonic06        | 192.168.122.106    |

1. Ssh to each node, check interface and IP status. Example:

```
ssh cisco@192.168.122.101

show interfaces status
show ip interfaces 
```

Example output:
```
cisco@sonic01:~$ show interfaces status
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
cisco@sonic01:~$ 
cisco@sonic01:~$ 
cisco@sonic01:~$ show ip interfaces
Interface    Master    IPv4 address/mask    Admin/Oper    BGP Neighbor    Neighbor IP
-----------  --------  -------------------  ------------  --------------  -------------
Ethernet16   Vrf1      10.101.1.1/24        up/up         N/A             N/A
Ethernet20   Vrf2      10.102.1.1/24        up/up         N/A             N/A
Loopback0              10.0.0.1/32          up/up         N/A             N/A
docker0                240.127.1.1/24       up/down       N/A             N/A
eth0                   192.168.122.101/24   up/up         N/A             N/A
lo                     127.0.0.1/16         up/up         N/A             N/A
```

2. Ssh into sonic01 then invoke vtysh to access FRR
```
ssh cisco@192.168.122.101
vtysh
```

Example:
```
cisco@sonic01:~$ vtysh

Hello, this is FRRouting (version 8.5.1).
Copyright 1996-2005 Kunihiro Ishiguro, et al.

sonic01# 
```

3. Run some FRR CLI commands:
```
show run
show int brief
show bgp summary
show bgp ipv6 unicast 
ping fc00:0:3::1
```

