#！/usr/bin/bash
ip=www.baidu.com
ping -c1 $ip &>/dev/null
if [ $? -eq 0 ] ;then
	echo "success"
else
	echo "fail"
fi

