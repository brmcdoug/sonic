# sonic-vw

This repo contains kvm xml and config files for launching and running a 12-node sonic-vs CLOS topology.

<img src="/diagrams/sonic-vs-clos.png" width="1200">

Instructions:
1. acquire a sonic-vs image
2. edit the image path in the sonic kvm xml files as needed
3. define and launch kvms:
```
sudo virsh define sonic01.xml
sudo virsh start sonic01
```
1. attach to vms via the console port defined in the xml files. 
   - Example xml:
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
1. default user/pw: admin/YourPaSsWoRd

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
7. ssh to mgt IP and apply configs per the config directory.
```
brmcdoug@naja:~/sonic$ ssh admin@192.168.122.116
admin@192.168.122.116's password: 
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

Last login: Sun Apr  9 02:00:57 2023
admin@sonic:~$ sudo config hostname sonic01
Please note loaded setting will be lost after system reboot. To preserve setting, run `config save`.
admin@sonic:~$ sudo config save
Existing files will be overwritten, continue? [y/N]: y
Running command: /usr/local/bin/sonic-cfggen -d --print-data > /etc/sonic/config_db.json
admin@sonic:~$ 
admin@sonic:~$ exit
logout
Connection to 192.168.122.116 closed.
brmcdoug@naja:~/sonic$ ssh admin@192.168.122.116
admin@192.168.122.116's password: 
Linux sonic001 5.10.0-18-2-amd64 #1 SMP Debian 5.10.140-1 (2022-09-02) x86_64
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

Last login: Sun Apr  9 02:03:49 2023 from 192.168.122.1
admin@sonic01:~$ 
```
