#!/bin/bash
echo 'exchange the key with some target host'
ssh-keygen -t rsa -P '' -f /root/.ssh/id_rsa
while read line
do
	#echo $line
	array_node=(`echo $line|cut -d \: -f 1` `echo $line|cut -d \: -f 2`)
	#echo '-2-'${array_node[2]}
	echo '-1-'${array_node[1]}
	echo 'ssh-copy-id -i /root/.ssh/id_rsa.pub root@'${array_node[1]}
	sleep 3s
	ssh-copy-id -i /root/.ssh/id_rsa.pub root@${array_node[1]}
done < ../file/host_list
