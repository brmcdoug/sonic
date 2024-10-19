#!/bin/bash
 ip link set down sonic01-16
 ip link set down sonic01-20
 ip link set down sonic02-16
 ip link set down sonic02-20
 ip link set down k8s-cp-node00
 ip link set down k8s-wkr-node00
 ip link set down k8s-wkr-node01
 ip link set down k8s-wkr-node02

 brctl delbr sonic01-16
 brctl delbr sonic01-20
 brctl delbr sonic02-16
 brctl delbr sonic02-20
 brctl delbr k8s-cp-node00
 brctl delbr k8s-wkr-node00
 brctl delbr k8s-wkr-node01
 brctl delbr k8s-wkr-node02



