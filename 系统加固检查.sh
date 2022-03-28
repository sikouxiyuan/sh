 \cp /etc/hosts{,.bak}
cat >/etc/hosts<<EOF
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
EOF
#0、更改yum源
rm -rf /etc/yum.repos.d/* 
cd /etc/yum.repos.d/
Wget http://116.196.72.35/CentOS-Base.repo

#安装epel 源
wget http://116.196.72.35/epel.repo
yum clean all
yum clean metadata
yum clean dbcache
yum makecache


#1、关闭selinux
sed -i.bak 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
grep SELINUX=disabled /etc/selinux/config
setenforce 0
getenforce
#2、关闭iptables
#/etc/init.d/iptables stop
#/etc/init.d/iptables stop
#chkconfig iptables off
#3、精简开机自启动服务
export LANG=en
chkconfig|egrep -v "crond|sshd|network|rsyslog|sysstat|rpcbind"|awk '{print "chkconfig",$1,"off"}'|bash

chkconfig --list|grep 3:on
#4、提权Yuheng可以sudo
useradd YuHeng -u 765
echo 123456|passwd --stdin YuHeng
\cp /etc/sudoers /etc/sudoers.ori
echo "YuHeng  ALL=(ALL) NOPASSWD: ALL " >>/etc/sudoers
tail -1 /etc/sudoers
visudo -c
#5、英文字符集
cp /etc/sysconfig/i18n /etc/sysconfig/i18n.ori
echo 'LANG="en_US.UTF-8"'  >/etc/sysconfig/i18n
source /etc/sysconfig/i18n
echo $LANG
#6、时间同步
echo '#time sync by lidao at 2017-03-08' >>/var/spool/cron/root
#echo '*/5 * * * * /usr/sbin/ntpdate 172.16.1.61  >/dev/null 2>&1' >>/var/spool/cron/root
crontab -l
#7、命令行安全（可不设置）
echo 'export TMOUT=300' >>/etc/profile
echo 'export HISTSIZE=5' >>/etc/profile
echo 'export HISTFILESIZE=5' >>/etc/profile
tail -3 /etc/profile
. /etc/profile
#8、加大文件描述
echo '*               -       nofile          65535 ' >>/etc/security/limits.conf
tail -1 /etc/security/limits.conf
#9、内核优化
cat >>/etc/sysctl.conf<<EOF
net.ipv4.tcp_fin_timeout = 2
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_keepalive_time = 600
net.ipv4.ip_local_port_range = 4000    65000
net.ipv4.tcp_max_syn_backlog = 16384
net.ipv4.tcp_max_tw_buckets = 36000
net.ipv4.route.gc_timeout = 100
net.ipv4.tcp_syn_retries = 1
net.ipv4.tcp_synack_retries = 1
net.core.somaxconn = 16384
net.core.netdev_max_backlog = 16384
net.ipv4.tcp_max_orphans = 16384
net.ipv4.ip_nonlocal_bind = 1
EOF
#以下参数是对iptables防火墙的优化，防火墙不开会提示，可以忽略不理。
net.nf_conntrack_max = 25000000
net.netfilter.nf_conntrack_max = 25000000
net.netfilter.nf_conntrack_tcp_timeout_established = 180
net.netfilter.nf_conntrack_tcp_timeout_time_wait = 120
net.netfilter.nf_conntrack_tcp_timeout_close_wait = 60
net.netfilter.nf_conntrack_tcp_timeout_fin_wait = 120
sleep 2
 cd /root
#wget http://172.16.1.61/ks_config/.vimrc
#shell切换更加强大的zsh
#说明：
#1.github是一个在线的代码仓库（网站），里面有各种开发者提交的代码
#2.git是将github上面的代码下载下来的工具
#3.zsh就是我们需要把bash替换的一个shell
#4.oh-my-zsh是一个强大的zsh插件，里面有很多主题，可以使我们显示，操作，git的使用更加方便
#5.ys就是一个很常用的主题
yum install -y git zsh && \
#切换成zsh \
 chsh -s `which zsh` && \
#把oh-my-zsh插件克隆到本地 \
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh && \
#把oh-my-zsh的zsh模板复制出来一份 \
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
  
sed  -i.bak  's#ZSH_THEME="robbyrussell"#ZSH_THEME="ys"#'  ~/.zshrc     
yum install bash-completion -y
yum install vim -y
sleep 3
yum install gcc gcc-c++ cmake    pcre-devel openssl-devel  curl-devel  libpng-devel  freetype-devel  php-mcrypt  libmcrypt  libmcrypt-devel libxslt libxslt-devel libxml2 libxml2-devel  zlib-devel libxml2-devel libjpeg-devel libjpeg-turbo-devel  freetype-devel libpng-devel gd-devel libcurl-devel libxslt-devel libmcrypt-devel mhash mcrypt -y
exit



 
 
 
 

