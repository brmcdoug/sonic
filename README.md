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
1. Acquire a sonic-vs image. The sonic-vs used to develop this lab was a Cisco 8101-32H sonic-vs
2. Edit the image path in the sonic kvm xml files as needed: [kvm-directory](./kvm/)
3. Optional - edit the following files to control the number of nodes you wish to launch:
   [ansible-hosts](./ansible/hosts)
   [sonic-nodes.yaml](./ansible/sonic_nodes.yaml) 
   [mgt-net.xml](./kvm/mgt-net.xml)
4. Run the ansible deploy script found here [deploy-playbook.yaml](./ansible/deploy-playbook.yaml)
   Note: the adjust user/pw credentials as needed
   ```
   cd ansible
   ansible-playbook -i hosts deploy-playbook.yaml -e "ansible_user=cisco ansible_ssh_pass=cisco123 ansible_sudo_pass=cisco123" -vv
   ```

5. 


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
