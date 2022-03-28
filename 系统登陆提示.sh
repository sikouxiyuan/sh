#!/bin/bash
echo 
a="\033[40;37m"
e="\033[0m"
b="\033[41;37m"
c="\033[42;37m"
f="\033[43;37m"
g="\033[44;37m"
h="\033[45;37m"
q="\033[46;37m"
cron=`crontab -l`
echo -e $a 'This is a private server,please leave,thanke you!' $e 
echo
echo -e $a Welcome $USER To Login To This Server! $e
echo
LoginUserNum=`who | wc -l`

OpenProcesNum=$(expr $(ps aux | wc -l) - 1)

FreeMem=`free -m | grep Mem: | awk '{print $4}'`

FreeBuffers=`free -m | grep - | awk '{print $3}'`

FreeCache=`free -m | grep - | awk '{print $4}'`

FreeSwap=`free -m | grep Swap: | awk '{print $4}'`

echo -e  " $a number of login users '(用户数量)':   $e" $LoginUserNum 
echo -e  " $b        $LoginUserNum                                    $e"
echo -e  " $a numbre of running processes '(进程)': $e" $OpenProcesNum 
echo -e  " $f        $OpenProcesNum                                   $e"
echo -e  " $a free memory size '(mb 可用内存)':     $e" $FreeMem 
echo -e  " $c        $FreeMem                                  $e"
echo -e  " $a free buffers size'(mb 内存可用缓存)': $e" $FreeBuffers 
echo -e  " $g        $FreeBuffers                                  $e"
echo -e  " $a free cache'(mb 可用缓存)':            $e" $FreeCache 
echo -e  " $h        $FreeCache                                 $e"
echo -e  " $a free swap space size '(mb 交换内存)': $e" $FreeSwap 
echo -e  " $q        $FreeSwap                                    $e"
echo -e  " $a view  crontab                     $e "    
echo -e  " $b  $cron                                           $e"
