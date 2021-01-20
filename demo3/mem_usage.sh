
mem_used=`free -m |grep '^Mem: '|awk '{print $3}'`
mem_total=`free -m |grep '^Mem: '|awk '{print $2}'`
mem_per=$((mem_used*100/mem_total))
echo "mem_per : $mem_per"
