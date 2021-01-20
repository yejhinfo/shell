#！/usr/bin/bash
#提示方法，如果用户没有加参数
if [ $# -eq 0 ];then
	echo "uasge: 'basename $0' file"   #basename只显示最后一个名字，eg：basename /home/wangji/cc,只显示cc
	exit
fi

##判断是否为文件
if [ ! -f $1 ];then
	echo "erro file!"
	exit
fi

for ip in 'cat $1'
do
	ping -c1 $ip &>/dev/null
	if [ $? -eq 0 ];then
		echo $ip "is up"
	else
		echo $ip "is down"
	fi
done