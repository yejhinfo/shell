#！/usr/bin/bash
ip=www.baidu.com
ping -c1 $ip &>/dev/null && echo "success" || echo "fail"
