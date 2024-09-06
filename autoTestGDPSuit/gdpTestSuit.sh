#!/bin/bash
#定义日志位置
LOGFILE='log'

#判断mnt目录下最新的任务编号目录
str=`ls -lt /mnt/jobs/dpdr-R1.5/builds/ | head -n 3 | sed -n '3p'`
str=$(echo "$str" | tr ' ' ':')
newbuild=(`echo $str|cut  -d  \:  -f  1` `echo $str|cut  -d  \:  -f  2` `echo $str|cut  -d  \:  -f  3` `echo $str|cut  -d  \:  -f  4` `echo $str|cut  -d  \:  -f  5` `echo $str|cut  -d  \:  -f  6` `echo $str|cut  -d  \:  -f  7` `echo $str|cut  -d  \:  -f  8` `echo $str|cut  -d  \:  -f  9` `echo $str|cut  -d  \:  -f  10` `echo $str|cut  -d  \:  -f  11` `echo $str|cut  -d  \:  -f  12`)

#判断参数为0则使用当前最新一次编译结果，否则按指定任务号执行。
if test $1 == '0'
	then taskNum=${newbuild[9]}
else
	taskNum=$1
fi

#记录开始时间
echo 'GDP test suit ' >> $LOGFILE
echo 'Begin : '`date +%Y-%m-%d_%H:%M:%S` >> $LOGFILE

#记录当前测试用的是默认版本还是指定版本 到日志文件
if test $1 == '0'
        then echo 'Fetch the newest build to test.' >> $LOGFILE
else
        echo 'Fetch the number '$1' build to test.' >> $LOGFILE
fi

#记录实际测试的build编号，gdp backend client 3个文件信息
echo 'the newest build path :  '$taskNum
echo 'The current test task num : '$taskNum >> $LOGFILE
echo 'judge the build result:'

#判断当前要测试版本的编译结果，是成功还是失败
logfile='ll /mnt/jobs/dpdr-R1.5/builds/'$taskNum'/log'
#echo 'logfile : '$logfile
logfile=$(echo "$logfile" | tr ' ' ':')
#echo 'logfile : '$logfile
logfilelist=(`echo $logfile|cut  -d  \:  -f  1` `echo $logfile|cut  -d  \:  -f  2`)
buildresult=`tail -n 1 ${logfilelist[1]}`
echo 'buildresult : '$buildresult
echo 'Current build result : '$buildresult  >> $LOGFILE

#如果编译成功则进入部署脚本
if [ "$buildresult" = "Finished: SUCCESS" ];
	 then  echo 'build correct'
	echo 'build correct ' >> $LOGFILE
	echo 'Starting deploy ... ... ' >> $LOGFILE
	#同样的参数给到部署文件
         ./fetchBuild.sh $1
	#在日志中记录完成时间
	echo 'Ending deploy '`date +%Y-%m-%d_%H:%M:%S` >> $LOGFILE
	#使用log接口，获得有效的token，以证明部署结果是否正确。
	rm -rf ./interface/deploy_result
	sleep 120s
	cd interface;java -jar ./interface.jar > ./deploy_result
	echo 'gdp page deploy over'
	#接口执行结果会覆盖写入deploy_result文件，按行读文件，将开头是token的行用 ： 劈开，查看第二个元素的值。
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
	#判断 ： 后面的内容是null还是否，null则日志内记录，本次部署异常。
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






