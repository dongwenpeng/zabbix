
模板介绍

这是Zabbix一套Linux基础监控模板，此模板提供：

1）CPU监控，包括：空闲时间、中断时间、iowait时间、系统使用时间、用户使用时间、每秒上下文切换次数、每秒中断次数、负载等。

2）内存&Swap监控，包括：总共内存、合法内存、使用内存、使用内存百分比、swap空闲大小、swap空闲百分比。

3）系统进程监控，包括：当前进程总数、当前正在运行的进行。

4）磁盘容量监控，包括：总大小、已经使用的和未使用的、已使用百分比、空闲Inode百分比；使用自动发现。

5）磁盘状态监控，包括：rrqm/s、wrqm/s、r/s、w/s、rsec/s、wsec/s、avgrq-sz、avgqu-sz、await、r_await w_await、svctm、%util，iostat命令获取的值。

6）网卡接口监控，包括：网卡进出流量、Packages QPS、drop packages统计、errors packages统计等。

7）网络连接监控，包括：tcp连接状态（closewait、timewait、established、listen、finwait）等。

8）网络Socket监控，包括：socket数量、tcp/udp mem、tcp_alloc等。

还包括系统本地时间、系统启动时间、/etc/passwd和/etc/hosts文件检测、主机名、最大打开文件数、系统信息等。




使用方法：

把Template_Linux_System_Base.xml文件导入到zabbix web界面中即可，另外需要在zabbix-agent端把zabbix_agentd.d
目录中的几个配置文件和scripts目录放在/etc/zabbix/zabbix_agentd.d/目录下，然后重启zabbix-agent即可。

另外针对此模板还提供了Grafana图形展示模板，是一个JSON格式，直接导入到Grafana即可。Grafana是一个非常漂亮的Dashboard展示程序。
