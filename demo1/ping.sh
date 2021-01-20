#！/usr/bin/bash
ping -c1 www.baidu.com &>/dev/null   && echo "success" || echo "fail"

/usr/bin/python <<EOF

print ‘this is python’
EOF
