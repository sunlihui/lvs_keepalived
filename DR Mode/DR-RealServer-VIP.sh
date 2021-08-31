#!/bin/bash
case "$1" in
start)
           echo "start LVS of RealServer DR"
           echo "1" >/proc/sys/net/ipv4/conf/lo/arp_ignore
           echo "2" >/proc/sys/net/ipv4/conf/lo/arp_announce
           echo "1" >/proc/sys/net/ipv4/conf/all/arp_ignore
           echo "2" >/proc/sys/net/ipv4/conf/all/arp_announce


           VIP="x.x.x.x";
           /sbin/ifconfig lo:vip $VIP broadcast $VIP netmask 255.255.255.255 up
           /sbin/route add -host $VIP dev lo:vip
       ;;
stop)
           /sbin/ifconfig lo:vip down

           echo "0" >/proc/sys/net/ipv4/conf/lo/arp_ignore
           echo "0" >/proc/sys/net/ipv4/conf/lo/arp_announce
           echo "0" >/proc/sys/net/ipv4/conf/all/arp_ignore
           echo "0" >/proc/sys/net/ipv4/conf/all/arp_announce
           echo "close LVS of RealServer DR"
           ;;

*)
          echo "Usage: $0 {start|stop}"
          exit 1
esac
exit 0
