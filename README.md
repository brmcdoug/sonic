## sonic-vs
This repo contains a set of sonic-vs network scenarios including ansible scripts, kvm xml, and config files for launching and running the topologies found in [diagrams](./diagrams/). The each project folder contains ansible scripts to deploy or destroy the topology. There are also two sets of router configurations, IPv6/BGP numbered and unnumbered, depending on your preference. The numbered and unnumbered folders contain their own READMEs as well.

### Contents
- [sonic-vs](#sonic-vs)
  - [Contents](#contents)
  - [Lab Setup:](#lab-setup)
  - [Proceed to deploy topology](#proceed-to-deploy-topology)

Example topology:
<img src="/diagrams/sonic-vs-2-tier-small-clos.png" width="1200">

### Lab Setup: 
1. Each sonic-vs node requires 1 vCPU and 4GB memory, so size your host/VM appropriately. The topologies in this repo has been tested on Ubuntu 20.04 and 22.04 both physical host and 22.04 VMs
  
2. If running this in your own lab please install ansible, and libvirt/qemu packages
  ```
  sudo apt-add-repository ppa:ansible/ansible
  sudo apt update
  apt install ansible bridge-utils qemu-kvm virtinst libvirt-daemon virt-manager -y
  ```
3. Acquire a sonic-vs image. The sonic-vs used to develop this lab was a Cisco 8101-32H emulation image

4. Decide which project you would like to launch:
   
   [Two-tier small clos](./diagrams/sonic-vs-2-tier-small-clos.png)

   [Two-tier rail optimized](./diagrams/sonic-vs-2-tier-rail-optimized.png)

   [Three-tier clos](./diagrams/sonic-vs-3-tier.png)

      Or use one of the three projects as a template to construct you own topology

5. ssh to the lab topology host/VM. If using Cisco dCloud "sonic-vs" lab:
```
ssh cisco@198.18.133.100
```
   * Note: all user/pw combinations in this project are *`cisco/cisco123`*

6. Make copies of your base sonic-vs image to align with the project/number of nodes you intend to launch. In this example the base image has been copied 6 times to match the small clos topology:
```
cisco@topology-host:~$ ls -la images/sonic-vs/
total 32670776
drwxrwxr-x 2 cisco cisco       4096 Oct 19 18:14 .
drwx------ 3 cisco cisco       4096 Oct 19 18:23 ..
-rw-rw-r-- 1 cisco cisco 2787901440 Oct 19 18:11 sonic-vs-c8101-32h-202311-01.img
-rw-rw-r-- 1 cisco cisco 2787901440 Oct 19 18:12 sonic-vs-c8101-32h-202311-02.img
-rw-rw-r-- 1 cisco cisco 2787901440 Oct 19 18:12 sonic-vs-c8101-32h-202311-03.img
-rw-rw-r-- 1 cisco cisco 2787901440 Oct 19 18:12 sonic-vs-c8101-32h-202311-04.img
-rw-rw-r-- 1 cisco cisco 2787901440 Oct 19 18:13 sonic-vs-c8101-32h-202311-05.img
-rw-rw-r-- 1 cisco cisco 2787901440 Oct 19 18:13 sonic-vs-c8101-32h-202311-06.img
```

1. If necessary edit the image path in the sonic kvm xml files to match the path and filenames you've given your image copies, [Example](./1-two-tier-small-clos/kvm/sonic01.xml#L28)

### Proceed to deploy topology

Click the link to open the readme instructions for your selected topology:
   
   [Two-tier small clos readme](./1-two-tier-small-clos/2-tier-small-clos-readme.md)

   [Two-tier rail-optimized readme](./2-two-tier-rail-optimized/2-tier-rail-optimized-readme.md)

   [Three-tier clos readme](./3-three-tier-clos/3-tier-clos-readme.md)

