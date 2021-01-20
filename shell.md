**举例简单例子：shell.sh**


```
 #!/usr/bin/bash
echo ‘checking...’ && ping -c 1 ‘www.baidu.com’&> /dev/null && echo ‘baidu.com is up’ || echo ‘baidu.com isdown...’

/usr/bin/python <<EOF
print ‘*’*50
print ‘this is python’
print ‘*’*50
EOF
```
&>混合输出重定向  /dev/null 将执行丢弃（不回显命令结果）


```

0表示标准输入
1表示标准输出
2表示标准错误输出
> 默认为标准输出重定向，与 1> 相同
2>&1 意思是把标准错误输出 重定向到 标准输出.
&>file 意思是把标准输出 和 标准错误输出 都重定向到文件file中
```


```
2.        #echo$?  返回上一个命令执行的返回值（代码）

shell 在执行某个命令的时候，会返回一个返回值，该返回值保存在 shell 变量 ?中。当? ==0 时，表示执行成功；当 $? == 1 （非0的数，返回值在0-255间），表示执行失败。
```


 


```
3. EOF和-EOF区别

EOF 只是一个标识，可以替换成任意的合法字符

没有-的话，EOF作为结束符，前面不能有任何tab制表符。
有-的话，EOF作为结束符，前面可以有tab制表符,容错率更高一点
```



```
4.cd ..和cd -和pushd,popd
cd .. ：返回上一级目录
cd - ：返回上一次目录
pushd ./  ：将此目录压栈
popd ：将目录弹出
```


```
^R              //搜索历史命令

^A              //光标移动到最前(Ahead)

^E              //光标移动到最后(End)

^Z              //暂停任务放到前台

jobs           //查看任务

fg               //调出后台任务

 
 
 
```

```
5.命令排序
; 不具备逻辑判断的功能
cd;eject

&& || 具备逻辑判断的功能

command & 后台执行
command &> /dev/null 混合重定向
command && command 命令顺序，逻辑判断
```



```
6.
*匹配任意多个字符
?配备任意一个字符
[]匹配括号中任意一个字符
()在子shell中执行
{}集合
\转义字符
```

```
7.
echo 输出有颜色的文字 echo -e "\e[1;31mTist is a red text."
                      echo -e "\e[1;31mTist is a red text.\e[0m"

```


```
8.定义变量
版本一
#！/usr/bin/bash
ip=www.baidu.com
ping -c1 $ip &>/dev/null   && echo "success" || echo "fail"
版本二
ip=www.baidu.com
if ping -c1 $ip &>/dev/null;then
	echo "success"
else
	echo "fail"
fi
版本三
（$?判断上个命令是不是对的）
#！/usr/bin/bash
ip=www.baidu.com
ping -c1 $ip &>/dev/null
if [ $? -eq 0 ] ;then
	echo "success"
else
	echo "fail"
fi

版本四
#！/usr/bin/bash
read -p "Plese input a ip: " ip
ping -c1 $ip &>/dev/null
if [ $? -eq 0 ] ;then
	echo "success"
else
	echo "fail"
fi

版本五（$1表示命令后的第一个参数）
#！/usr/bin/bash
ping -c1 $1 &>/dev/null
if [ $? -eq 0 ] ;then
	echo "success"
else
	echo "fail"
fi

```


```
预定义变量
$0 脚本名
$* 所有的参数
$@ 所有的参数
$# 参数的个数
$$ 当前进程的PID
$! 上一个后台进程的PID
$? 上一个命令的返回值，0表示成功

#！/usr/bin/bash
#如果用户没加参数
if [ $# -eq 0 ];then
	echo "usage : 'basename $0' file"
	exit
fi

if [ ! -f $1 ];then
	echo "error file"
	exit
fi


for ip in 'cat $1'
do
	ping -c1 $ip &>/dev/null
	if [ $? -eq 0 ];then
		echo "$ip is up"
	else
		echo "$ip is down"
	fi
done

```

**2.变量的赋值
shell默认将变量看成是字符串类型
显示赋值**

```
变量名=变量值
eg：
ip1=1.1.1.2
school="Wangji hello"
today=`date +%F；echo $today` ##``代表反引号，叫做命令替换(先把命令执行一遍，再做别的事情)，等价于today=$(data+%F)
today=$(date +%F)

##上面的结果都是将字符串直接或者间接的赋值给变量
```


**---------------------------------------------------------------**-

**1.整数运算**


```
方法1：expr（用得很少）
num1=1
num2=2
expr 1+2
expr $num1+$num2   + -  \*(转义了一下) /  %

方法2：$(())        用的多
num1=1
num2=2
echo $(($num1+$num2)) +-*/%
echo $((5-3*2))
sum= $((1+2));echo $sum
echo $((2**3))##2的三次方

方法3：$[]
echo $[5+2]     +-*/%
echo $[5*2]


方法4：let       用的多
let num=2+3;echo $sum
let i++;echo $i

eg:
#!/usr/bin/bash
mem_used=`free -m|grep '^Men:'|awk '{print $3}'`
mem_total=`free -m|grep '^Men:'|awk '{print $2}'`
mem_percent=$((mem_used*100/mem_total))

echo "当前内存使用的百分比：$mem_percent"

./memuse.sh
或者使用调试方式去执行脚本:
bash -vx memuse.sh


eg：ping1.sh
#!/usr/bin/bash
##ping 5次
ip=10.18.1.1
i=1
while [ $i -le 5 ]##<=
do
	ping -c1 $ip &>/dev/null
	if [ $? -eg 0 ];then
		echo "$ip is ip..."
	fi
	let i++
done

```
2.小数运算
bc计算器

```
echo "2*4"|bc
echo "2^4"|bc
awk 'BEGIN{print 1/2}'
```



```
1.变量内容的删除
（1）url=www.sina.com.cn
echo ${#url}   获取变量值的长度
15

echo ${url}   标准查看
www.sina.com.cn

echo ${url#*.}	从前往后，最短匹配
sina.com.cn

echo ${url##*.} 从前往后，最长匹配，贪婪匹配
cn

（2）url=www.sina.com.cn
echo ${url}
www.sina.com.cn

echo ${url%.*}  从后往前，最短匹配
www.sina.com

echo ${url%%.*} 从后往前，最长匹配，贪婪匹配
www

（3）url=www.sina.com.cn
echo ${url#a.}
www.sina.com.cn  错误的结果

echo ${url#*sina.}
com.cn


2.索引及切片
索引从0开始
url=www.sina.com.cn
echo ${url}   标准查看
www.sina.com.cn

echo ${url:0:5}    从第0个取，取5个
www.s

echo ${url:5:5} 
ina.c

echo ${url:5}  从第5个开始
ina.com.cn


3.变量内容的替换1
url=www.sina.com.cn
echo ${url}   标准查看
www.sina.com.cn

echo ${url/sina/baidu}
www.baidu.com.cn

echo ${url/n/N}
www.siNa.com.cn

echo ${url//n/N}      //表示贪婪匹配
www.siNa.com.cN

4.变量内容的替换2
（1）-的意思：凡是变量有被定义过，就不能被替代
unset var1   删除变量var1的值
echo ${var1}
echo ${var1-aaa}
aaa

var2=111
echo ${var1-bbb}
bbb

var3=
echo ${var3-ccc}

${变量名-新的变量值}
变量没有被赋值：会使用“新的变量值”替换
变量有被赋值(包括空值)：不会被替代

（2）:-表示：变量若是没有值或者是空值，就给你个值
unset var1
unset var2
unset var3

var2=
var3=111
echo ${var1:-aaaa}
aaaa
echo ${var2:-aaaa}
aaaa
echo ${var3:-aaaa}
111

${变量名:-新的变量值}
变量没有被赋值(包括空值)：都会使用“新的变量值”替代
变量有被赋值：不会被替代


（3）其它
echo ${var3+aaa}
echo ${var3:+aaa}

echo ${var3=aaa}
echo ${var3:=aaa}

echo ${var3?aaa}
echo ${var3:?aaa}
```



```
1.i++与++i的区别
主要是对表达式的赋值有影响
对于变量的值来讲没影响
unset i
unset j
i=1
j=1
let x=i++   先赋值，再运算
let y=++j	先运算，再赋值

echo $i
2
echo $j
2

echo $x
1
echo $y
2

```

