#/bin/bash
#�鿴ָ��IP��ɫ�Ƿ������Ҫ��Ŀ¼�����û���򴴽�
echo $1' : The target host'
echo $2' : The target path'

ssh root@$1 'rm -rf '$2
ssh root@$1 'mkdir -p '$2