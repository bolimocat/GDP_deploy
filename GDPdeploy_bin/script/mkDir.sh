#/bin/bash
#查看指定IP角色是否存在需要的目录，如果没有则创建
echo $1' : The target host'
echo $2' : The target path'

ssh root@$1 'rm -rf '$2
ssh root@$1 'mkdir -p '$2