#!/bin/bash

if [[ $USER != "root" ]]; then 
		echo "This script must be run as root!" 
		exit 1
fi

usage="./gos-control.sh [arguments]"
VERBOSE=true
counter="0"

while getopts 'abcdefghklm?' option
do
  case "$option" in
  a) systemctl start GOSSIP
     systemctl is-active GOSSIP
     ((counter+=1))
     ;;
  b) systemctl stop GOSSIP
     systemctl is-active GOSSIP
     ((counter+=1))
     ;;
  c) systemctl status GOSSIP
     ((counter+=1))
     ;;
  d) systemctl is-enabled GOSSIP
     ((counter+=1))
     ;;
  e) gossipcoin-cli mnsync status
     ((counter+=1))
     ;;
  f) gossipcoin-cli masternode status
     ((counter+=1))
     ;;
  g) gossipcoin-cli getblockcount
     ((counter+=1))
     ;;  
  h) $usage
     ((counter+=1))
     ;; 
  k) ufw status
     ((counter+=1))
     ;;
  l) cat .gossipcoin/gossipcoin.conf
     ((counter+=1))
     ;;
  m) more /var/log/ufw.log
     ((counter+=1))
     ;;
  ?) $usage
     exit 0
     ;;
  esac
done

if [ $counter -eq 1 ];then
  exit 0
else
  echo $usage
  exit 1
fi
