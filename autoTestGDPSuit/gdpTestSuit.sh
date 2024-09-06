#!/bin/bash
#������־λ��
LOGFILE='log'

#�ж�mntĿ¼�����µ�������Ŀ¼
str=`ls -lt /mnt/jobs/dpdr-R1.5/builds/ | head -n 3 | sed -n '3p'`
str=$(echo "$str" | tr ' ' ':')
newbuild=(`echo $str|cut  -d  \:  -f  1` `echo $str|cut  -d  \:  -f  2` `echo $str|cut  -d  \:  -f  3` `echo $str|cut  -d  \:  -f  4` `echo $str|cut  -d  \:  -f  5` `echo $str|cut  -d  \:  -f  6` `echo $str|cut  -d  \:  -f  7` `echo $str|cut  -d  \:  -f  8` `echo $str|cut  -d  \:  -f  9` `echo $str|cut  -d  \:  -f  10` `echo $str|cut  -d  \:  -f  11` `echo $str|cut  -d  \:  -f  12`)

#�жϲ���Ϊ0��ʹ�õ�ǰ����һ�α�����������ָ�������ִ�С�
if test $1 == '0'
	then taskNum=${newbuild[9]}
else
	taskNum=$1
fi

#��¼��ʼʱ��
echo 'GDP test suit ' >> $LOGFILE
echo 'Begin : '`date +%Y-%m-%d_%H:%M:%S` >> $LOGFILE

#��¼��ǰ�����õ���Ĭ�ϰ汾����ָ���汾 ����־�ļ�
if test $1 == '0'
        then echo 'Fetch the newest build to test.' >> $LOGFILE
else
        echo 'Fetch the number '$1' build to test.' >> $LOGFILE
fi

#��¼ʵ�ʲ��Ե�build��ţ�gdp backend client 3���ļ���Ϣ
echo 'the newest build path :  '$taskNum
echo 'The current test task num : '$taskNum >> $LOGFILE
echo 'judge the build result:'

#�жϵ�ǰҪ���԰汾�ı��������ǳɹ�����ʧ��
logfile='ll /mnt/jobs/dpdr-R1.5/builds/'$taskNum'/log'
#echo 'logfile : '$logfile
logfile=$(echo "$logfile" | tr ' ' ':')
#echo 'logfile : '$logfile
logfilelist=(`echo $logfile|cut  -d  \:  -f  1` `echo $logfile|cut  -d  \:  -f  2`)
buildresult=`tail -n 1 ${logfilelist[1]}`
echo 'buildresult : '$buildresult
echo 'Current build result : '$buildresult  >> $LOGFILE

#�������ɹ�����벿��ű�
if [ "$buildresult" = "Finished: SUCCESS" ];
	 then  echo 'build correct'
	echo 'build correct ' >> $LOGFILE
	echo 'Starting deploy ... ... ' >> $LOGFILE
	#ͬ���Ĳ������������ļ�
         ./fetchBuild.sh $1
	#����־�м�¼���ʱ��
	echo 'Ending deploy '`date +%Y-%m-%d_%H:%M:%S` >> $LOGFILE
	#ʹ��log�ӿڣ������Ч��token����֤���������Ƿ���ȷ��
	rm -rf ./interface/deploy_result
	sleep 120s
	cd interface;java -jar ./interface.jar > ./deploy_result
	echo 'gdp page deploy over'
	#�ӿ�ִ�н���Ḳ��д��deploy_result�ļ������ж��ļ�������ͷ��token������ �� �������鿴�ڶ���Ԫ�ص�ֵ��
	prefix="Token"
 	while read line
	do
#		echo $line
		if [[ $line == $prefix* ]];
		then  weblogin=$line
		fi
	done<./deploy_result	
	#echo 'weblogin : '$weblogin
	loginresult=(`echo $weblogin|cut  -d  \:  -f  1` `echo $weblogin|cut  -d  \:  -f  2`)
	#�ж� �� �����������null���Ƿ�null����־�ڼ�¼�����β����쳣��
#	echo ' -- '${loginresult[1]}
	if [ "${loginresult[1]}" = "null" ];
		then echo 'GDP login failed , perhaps deploy failed ... '
		echo 'GDP login failed , perhaps deploy failed ... ' >> $LOGFILE
	else 
		echo 'Deploy success'
		echo 'Deploy success'  >> $LOGFILE
	fi
	
#else if [ "$buildresult" = "Finished: FAILED" ];
else
	echo 'build faild'
	echo 'build faild'  >> $LOGFILE
#	exit 0
#	fi
fi

echo 'GDP test suit over' >> $LOGFILE
echo 'End : '`date +%Y-%m-%d_%H:%M:%S` >> $LOGFILE
echo '--------------------------------------------' >> $LOGFILE
echo '' >> $LOGFILE
echo '' >> $LOGFILE






