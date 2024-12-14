#!/bin/bash

 brctl addbr cp-node00-0
 brctl addbr cp-node00-1
 brctl addbr cp-node00-2
 brctl addbr cp-node00-3

 brctl addbr wkr-node01-0
 brctl addbr wkr-node01-1
 brctl addbr wkr-node01-2
 brctl addbr wkr-node01-3

 brctl addbr wkr-node02-0
 brctl addbr wkr-node02-1
 brctl addbr wkr-node02-2
 brctl addbr wkr-node02-3

 brctl addbr wkr-node03-0
 brctl addbr wkr-node03-1
 brctl addbr wkr-node03-2
 brctl addbr wkr-node03-3

 ip link set up cp-node00-0
 ip link set up cp-node00-1
 ip link set up cp-node00-2
 ip link set up cp-node00-3

 ip link set up wkr-node01-0
 ip link set up wkr-node01-1
 ip link set up wkr-node01-2
 ip link set up wkr-node01-3

 ip link set up wkr-node02-0
 ip link set up wkr-node02-1
 ip link set up wkr-node02-2
 ip link set up wkr-node02-3

 ip link set up wkr-node03-0
 ip link set up wkr-node03-1
 ip link set up wkr-node03-2
 ip link set up wkr-node03-3

