#!/bin/bash

#####################################################################################################################
#    update_dns.sh   :  A simple script to update DNS for new ip address due to a Wifi or LAN network change        #
#-------------------------------------------------------------------------------------------------------------------#
#    Author: Richard Hogan               mail.rich.hogan@gmail.com            https://github.com/richardhogan       #
#                                                                                                                   #
#                                                                                                                   #
#    PURPOSE:  Script will use others tools including 'facter' and 'sed' to programatically update the local        #
#              DNS zone file with a new IP address and restart the Docker container running the BIND9 DNS server    #
#              for your environment.                                                                                #
#                                                                                                                   #
# 

MY_IP=$(ifconfig en0 | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')

MY_ZONE_FILE="local.zone"
MY_MSG="   ; This is the local host.  IP will change with each DHCP.  Use update_dns.sh script"

echo "Using "$(pwd)"/"$MY_ZONE_FILE" as the file to update"
read $CR

sed -i ".bak" '/www/d' $MY_ZONE_FILE
echo "www    IN  A      " $MY_IP $MY_MSG >> $MY_ZONE_FILE

MY_DNS_CONTAINER_ID=$(docker ps | grep bind | cut -d' ' -f 1)
MY_DNS_CONTAINER_NAME=$(docker ps | grep bind | rev | cut -d' ' -f 1 | rev)

echo "Using running DNS container named: "$MY_DNS_CONTAINER_NAME", with container ID: "$MY_DNS_CONTAINER_ID 

docker cp $MY_ZONE_FILE $MY_DNS_CONTAINER_ID:/etc/bind
docker exec $MY_DNS_CONTAINER_ID chown bind:bind /etc/bind/$MY_ZONE_FILE
docker exec $MY_DNS_CONTAINER_ID service bind9 restart
docker start $MY_DNS_CONTAINER_ID
