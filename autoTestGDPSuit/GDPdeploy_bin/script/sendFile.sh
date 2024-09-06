#!/bin/bash
echo 'send new build files to target host'
#$1 host 2 folder 3 role 4 file

if test $3 = 'arm'
	then echo 'scp -r ./build/arm/'$4' root@'$1':'$2' >/dev/null 2&>1 &'
	scp -r ./build/arm/$4 root@$1:$2
fi
if test $3 = 'x86'
	then scp -r ./build/x86/$4 root@$1:$2

fi
