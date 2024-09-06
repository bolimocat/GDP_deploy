#!/bin/bash
#$1 is role , $2 is ip_list,$3 is path , $4 is file

array_node=(`echo $2|cut -d \: -f 1` `echo $2|cut -d \: -f 2`  `echo $2|cut -d \: -f 3`  `echo $2|cut -d \: -f 4`  `echo $2|cut -d \: -f 5`  `echo $2|cut -d \: -f 6`)
path_node=(`echo $3|cut -d \:  -f  1`  `echo $3|cut  -d   \:  -f  2` `echo $3|cut  -d  \:  -f  3`)
file_node=(`echo $4|cut -d \:  -f  1`  `echo $4|cut  -d   \:  -f  2` `echo $4|cut  -d  \:  -f  3`)
echo '--role-  '$1
echo '--host-  '$2
echo '--path-  '$3
echo '--file-  '$4
echo '--${array_node[0]}--  '${array_node[0]}
echo '---  '${array_node[1]}
echo '---  '${array_node[2]}
echo '---  '${array_node[3]}
echo '---  '${array_node[4]}
echo '---  '${array_node[5]}

echo '---  '${path_node[0]}
echo '---  '${path_node[1]}
echo '---  '${path_node[2]}


echo '---  '${file_node[0]}
echo '---  '${file_node[1]}
echo '---  '${file_node[2]}

echo '----aio = '$5
echo '----ARTH = '$1


if test  $5 = '1'
	then echo "AIO"
	if test $1 = 'x86'
		then echo "-- aio ,is x86 ---"
		ssh root@${array_node[0]}  "cd ${path_node[0]};chmod +x  ${file_node[0]} "
		ssh root@${array_node[0]}  "cd ${path_node[0]}  ;./${file_node[0]} -- --v --single-server --ip ${array_node[0]} --docker-images=docker-images-gdp-20240426.tar.bz2    >> ./install_x86_aio_admin_storage.log "
		ssh root@${array_node[0]}  "cd ${path_node[1]};touch storage;chmod +x  ${file_node[1]} "
		ssh root@${array_node[0]}  "cd ${path_node[1]};./${file_node[1]} > ./install_x86_storage.log;echo $? >> ./install_x86_storage.log"
		ssh root@${array_node[2]}  "cd ${path_node[2]};chmod +x  ${file_node[2]};./${file_node[2]} > ./install_x86_client.log;echo $? >> ./install_x86_client.log "
		ssh root@${array_node[3]}  "cd ${path_node[2]};chmod +x  ${file_node[2]};./${file_node[2]} > ./install_x86_client.log;echo $? >> ./install_x86_client.log"
		ssh root@${array_node[4]}  "cd ${path_node[2]};chmod +x  ${file_node[2]};./${file_node[2]} > ./install_x86_client.log;echo $? >> ./install_x86_client.log"
		ssh root@${array_node[5]}  "cd ${path_node[2]};chmod +x  ${file_node[2]};./${file_node[2]} > ./install_x86_client.log;echo $? >> ./install_x86_client.log"
	fi
fi

if test  $5 = '0'
	then echo 'not aio'
	if test $1 = 'x86'
		then echo "-- not aio ,is x86 ---"
		ssh root@${array_node[0]}  "cd ${path_node[0]};chmod +x  ${file_node[0]} " 
		ssh root@${array_node[0]}  "cd ${path_node[0]}  ;./${file_node[0]}  -- --docker-images=docker-images-gdp-20240426.tar.bz2 > ./install_x86_admin.log;echo $? >> ./install_x86_admin.log "
		ssh root@${array_node[1]}  "cd ${path_node[1]};chmod +x  ${file_node[1]} "
		ssh root@${array_node[1]}  "cd ${path_node[1]};./${file_node[1]} > ./install_x86_storage.log;echo $? >> ./install_x86_storage.log"
		ssh root@${array_node[2]}  "cd ${path_node[2]};chmod +x  ${file_node[2]};./${file_node[2]} > ./install_x86_client.log;echo $? >> ./install_x86_client.log "
		ssh root@${array_node[3]}  "cd ${path_node[2]};chmod +x  ${file_node[2]};./${file_node[2]} > ./install_x86_client.log;echo $? >> ./install_x86_client.log"
		ssh root@${array_node[4]}  "cd ${path_node[2]};chmod +x  ${file_node[2]};./${file_node[2]} > ./install_x86_client.log;echo $? >> ./install_x86_client.log"
		ssh root@${array_node[5]}  "cd ${path_node[2]};chmod +x  ${file_node[2]};./${file_node[2]} > ./install_x86_client.log;echo $? >> ./install_x86_client.log"

	fi

fi

