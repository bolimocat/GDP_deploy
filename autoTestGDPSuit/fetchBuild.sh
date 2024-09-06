#!/bin/bash
LOGFILE='log'
str=`ls -lt /mnt/jobs/dpdr-R1.5/builds/ | head -n 3 | sed -n '3p'`
str=$(echo "$str" | tr ' ' ':')
#echo $str

newbuild=(`echo $str|cut  -d  \:  -f  1` `echo $str|cut  -d  \:  -f  2` `echo $str|cut  -d  \:  -f  3` `echo $str|cut  -d  \:  -f  4` `echo $str|cut  -d  \:  -f  5` `echo $str|cut  -d  \:  -f  6` `echo $str|cut  -d  \:  -f  7` `echo $str|cut  -d  \:  -f  8` `echo $str|cut  -d  \:  -f  9` `echo $str|cut  -d  \:  -f  10` `echo $str|cut  -d  \:  -f  11` `echo $str|cut  -d  \:  -f  12`)

#echo 'the newest build path :  '${newbuild[9]}

if test $1 == '0'
        then taskNum=${newbuild[9]}
else
        taskNum=$1
fi


newgdp='ll /mnt/jobs/dpdr-R1.5/builds/'$taskNum'/archive/*.sh'
newgdp=$(echo "$newgdp" | tr ' ' ':')
gdpfile=(`echo $newgdp|cut  -d  \:  -f  1` `echo $newgdp|cut  -d  \:  -f  2`)
echo 'the gdp file : '${gdpfile[1]}
echo 'gdp file is '${gdpfile[1]} >> $LOGFILE

newbackend='ll /mnt/jobs/dpdr-R1.5/builds/'$taskNum'/archive/gdp-dist/backends/x86_64/*.run'
newbackend=$(echo "$newbackend" | tr ' ' ':')
backendfile=(`echo $newbackend|cut  -d  \:  -f  1` `echo $newbackend|cut  -d  \:  -f  2`)
echo 'the backend file : '${backendfile[1]}
echo 'backend file is : '${backendfile[1]} >> $LOGFILE

newclient='ll /mnt/jobs/dpdr-R1.5/builds/'$taskNum'/archive/gdp-dist/clients/x86_64/*.run'
newclient=$(echo "$newclient" | tr ' ' ':')
clientfile=(`echo $newclient|cut  -d  \:  -f  1` `echo $newclient|cut  -d  \:  -f  2`)
echo 'the client file : '${clientfile[1]}
echo 'client file is : '${clientfile[1]} >> $LOGFILE

echo 'clean the deploy tool folder :'
echo 'clean the deploy tool folder ... ... '`date +%Y-%m-%d_%H:%M:%S` >> $LOGFILE
rm -rf ./GDPdeploy_bin/build/x86/*.run
rm -rf ./GDPdeploy_bin/build/x86/*.sh
sleep 1s

echo 'fetch  build files'
echo 'fetch building  from '$taskNum >> $LOGFILE
echo 'cp gdp '`date +%Y-%m-%d_%H:%M:%S` >> $LOGFILE
cp -rf ${gdpfile[1]} ./GDPdeploy_bin/build/x86/gdp-1.9.9-R1.5.sh
echo 'cp backend '`date +%Y-%m-%d_%H:%M:%S` >> $LOGFILE
cp -rf ${backendfile[1]} ./GDPdeploy_bin/build/x86/backend-node.1.9.9.run
echo 'cp client '`date +%Y-%m-%d_%H:%M:%S` >> $LOGFILE
cp -rf ${clientfile[1]} ./GDPdeploy_bin/build/x86/client-node.1.9.9.run

echo 'deploy the building on host list'
echo 'Start to deploy GDP ... ...'`date +%Y-%m-%d_%H:%M:%S` >> $LOGFILE
cd ./GDPdeploy_bin/
./GDPdeploy

#echo 'replace the properties'
#/mnt/jobs/dpdr-R1.5/builds/45/archive/gdp-1.9.9-R1.5-b45-.sh
#gdpname=(`echo ${gdpfile[1]}|cut  -d  \/  -f  1` `echo ${gdpfile[1]}|cut  -d  \/  -f  2`  `echo ${gdpfile[1]}|cut  -d  \/  -f  3`)   


#echo '-- '${gdpname[3]}



