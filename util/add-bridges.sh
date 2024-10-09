#!/bin/bash

 brctl addbr sonic01-16
brctl addbr sonic01-20
 brctl addbr sonic02-16
 brctl addbr sonic02-20
 brctl addbr k8s-cp-node00
 brctl addbr k8s-wkr-node00
 brctl addbr k8s-wkr-node01
 brctl addbr k8s-wkr-node02

 ip link set up sonic01-16
 ip link set up sonic01-20
 ip link set up sonic02-16
 ip link set up sonic02-20
 ip link set up k8s-cp-node00
 ip link set up k8s-wkr-node00
 ip link set up k8s-wkr-node01
 ip link set up k8s-wkr-node02

