#！/usr/bin/bash
ip=www.baidu.com
if ping -c1 $ip &>/dev/null;then
	echo "success"
else
	echo "fail"
fi

