## sonic-vs
This repo contains kvm xml and config files for launching and running a sonic-vs CLOS topology as shown in the diagram. Example Ansible scripts are provided to either deploy or destroy the topology. There are also two sets of router configurations, IPv6/BGP numbered and unnumbered, depending on your preference. The numbered and unnumbered folders contain their own READMEs as well.

<img src="/diagrams/sonic-vs-clos.png" width="1200">

### Requirements: 
* 1 vCPU and 4GB memory per sonic-vs. The topology in this repo has been tested on an Ubuntu 20.04 physical host and 22.04 VM.
* Ansible, libvirt/qemu, and virsh commands
  ```
  sudo apt-add-repository ppa:ansible/ansible
  sudo apt update
  apt install ansible bridge-utils qemu-kvm virtinst libvirt-daemon virt-manager -y
  ```

### sonic-vs lab instructions:
1. Acquire a sonic-vs image. The sonic-vs used to develop this lab was a Cisco 8101-32H emulation
   
2. Make copies of the image to align with the number of nodes you intend to launch
   
3. Edit the image path in the sonic kvm xml files to match the path and filenames you've given your image copies, example: https://github.com/brmcdoug/sonic-vs/blob/main/kvm/sonic01.xml#L28
   
4. Optional - edit the following files to control the number of nodes you wish to launch:
   [ansible-hosts](./ansible/hosts)
   [sonic-nodes.yaml](./ansible/sonic_nodes.yaml) 
   [mgt-net.xml](./kvm/mgt-net.xml)

#### Ansible scripts
4. Run the ansible deploy script found here [deploy-playbook.yaml](./ansible/deploy-playbook.yaml)
   Note: adjust user/pw credentials as needed. The script will take about 3 minutes to run.
   ```
   cd ansible
   ansible-playbook -i hosts deploy-playbook.yaml -e "ansible_user=cisco ansible_ssh_pass=cisco123 ansible_sudo_pass=cisco123" -vv
   ```

5. Once the script completes the sonic-vs nodes should all be up and running using the configurations found in the [config-unnumbered](./config-unnumbered/) directory

   * Note: If you are running the deploy script for the first time please proceed. If you've already run it and wish to make changes then re-run the script, please run the "destroy" script first

   ```
   # ansible-playbook -i hosts destroy-playbook.yaml -e "ansible_user=cisco ansible_ssh_pass=cisco123 ansible_sudo_pass=cisco123" -vv
   ```

   * Note: to switch to numbered config (ie, sonic-vs nodes having IP addresses rather than rely on IPv6 link-local) edit this line in the ansible script: https://github.com/brmcdoug/sonic-vs/blob/main/ansible/deploy-playbook.yaml#L68

6. Test: ssh to sonic01, check interface status
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

7. While still on sonic01, invoke vtysh to access FRR
```
vtysh
```

Example:
```
cisco@sonic01:~$ vtysh

Hello, this is FRRouting (version 8.5.1).
Copyright 1996-2005 Kunihiro Ishiguro, et al.

sonic01# 
```

8. Run some FRR CLI commands:
```
show run
show int brief
show bgp summary
show bgp ipv6 unicast 
ping fc00:0:3::1
```

### Appendix
Original/manual deploy instructions:

1. define and launch kvms:
```
sudo virsh define sonic01.xml
sudo virsh start sonic01
```
2. attach to sonic VMs via the console port defined in the xml files. 
   - Example from sonic01 xml:
```
    <console type='tcp'>
      <source mode='bind' host='127.0.0.1' service='8001'/>
      <protocol type='telnet'/>
      <target type='serial' port='0'/>
    </console>
```
   - telnet to console:
```
telnet localhost 8001
```
1. default SONiC user/pw: admin/YourPaSsWoRd

2. the xml files create a mgt port attached to linux bridge virbr0, which should allocate a DHCP address for the mgt port IP. Example:
```
brmcdoug@naja:~/sonic$ telnet 0 8001
Trying 0.0.0.0...
Connected to 0.
Escape character is '^]'.

sonic login: admin
Password: 
Linux sonic 5.10.0-18-2-amd64 #1 SMP Debian 5.10.140-1 (2022-09-02) x86_64
You are on
  ____   ___  _   _ _  ____
 / ___| / _ \| \ | (_)/ ___|
 \___ \| | | |  \| | | |
  ___) | |_| | |\  | | |___
 |____/ \___/|_| \_|_|\____|

-- Software for Open Networking in the Cloud --

Unauthorized access and/or use are prohibited.
All access and/or use are subject to monitoring.

Help:    https://sonic-net.github.io/SONiC/

Last login: Sat Apr  8 02:33:24 UTC 2023 from 192.168.122.1 on pts/0
admin@sonic:~$ show ip interfaces 
Interface    Master    IPv4 address/mask    Admin/Oper    BGP Neighbor    Neighbor IP
-----------  --------  -------------------  ------------  --------------  -------------
docker0                240.127.1.1/24       up/down       N/A             N/A
eth0                   192.168.122.116/24   up/up         N/A             N/A
lo                     127.0.0.1/16         up/up         N/A             N/A
admin@sonic:~$ 
```
7. ssh to the mgt IP then scp the config files to the sonic instance
```
scp brmcdoug@192.168.122.1:/home/brmcdoug/sonic-vs/config/sonic04/* .
```
```
admin@sonic04:~$ scp brmcdoug@192.168.122.1:/home/brmcdoug/sonic-vs/config/sonic04/* .
brmcdoug@192.168.122.1's password: 
config_db.json   100% 8426     5.5MB/s   00:00    
frr.conf        100% 2383     3.1MB/s   00:00
```
8. Replace the original config files with your new ones:
```
sudo mv config_db.json /etc/sonic/
sudo mv frr.conf /etc/sonic/frr/
```
9. reload config:
```
sudo config reload
```
Output:
```
admin@sonic04:~$ sudo config reload
Clear current config and reload config in config_db format from the default config file(s) ? [y/N]: y
Disabling container monitoring ...
Stopping SONiC target ...
Running command: /usr/local/bin/sonic-cfggen  -j /etc/sonic/init_cfg.json  -j /etc/sonic/config_db.json  --write-to-db
Running command: /usr/local/bin/db_migrator.py -o migrate
Running command: /usr/local/bin/sonic-cfggen -d -y /etc/sonic/sonic_version.yml -t /usr/share/sonic/templates/sonic-environment.j2,/etc/sonic/sonic-environment
Restarting SONiC target ...
Enabling container monitoring ...
Reloading Monit configuration ...
Reinitializing monit daemon
```
Note: config reload takes a couple minutes, and interfaces coming up takes a couple minutes more

Handy sonic CLI commands:
```
show interfaces status
show ip interfaces
show ipv6 interfaces
```
Invoke FRR CLI:
```
vtysh
```
Example:
```
admin@sonic04:~$ vtysh

Hello, this is FRRouting (version 8.4-dev).
Copyright 1996-2005 Kunihiro Ishiguro, et al.

sonic04# 
```

### Notes, caveats:

As of May 15, 2023 SONiC-VS and the FRR implementation have a couple quirks to be aware of:

1.	 L3VPN forwarding requires setting the VRF strict mode sysctl kernel property followed by a config reload:
```
net.vrf.strict_mode = 1
```

2.	FRR also applies some default settings for BGP and RT values after events like reloads, which require cleanup. I’ll discuss these items with the engineering team and see what we can do to correct that. In the meantime:

```
no ip prefix-list PL_LoopbackV4 seq 5 permit 10.1.0.1/32
no route-map RM_SET_SRC6 permit 10
no route-map RM_SET_SRC permit 10
no ip protocol bgp route-map RM_SET_SRC
no ipv6 protocol bgp route-map RM_SET_SRC6
```
