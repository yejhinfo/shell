#！/usr/bin/bash
ping -c1 $1 &>/dev/null
if [ $? -eq 0 ] ;then
	echo "success"
else
	echo "fail"
fi