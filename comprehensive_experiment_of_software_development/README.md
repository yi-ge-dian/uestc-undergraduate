# UESTC 软件开发综合实验

> # Backupup项目实现及运行

本项目在windows下面开发，以下操作只针对于windows，QT采用版本为5.12.2,MINGW采用版本8.10.0 32位

> 如果希望上传到您自己的服务器，您需要做以下操作：

1.将backup.jar包上传到您自己的服务器上，并使用该指令来运行该jar包：`nohup java -jar backup.jar &` 此命令会使你的服务器一直运行该jar包，如果想关掉，请采用该命令：`ps aux|grep backup.jar` 找到对应的进程号pid，`kill -9 pid(你刚才查到的具体pid号码)` ，如果想要只运行一次，请采用java -jar backup.jar

2.当然运行上述程序，需要你的服务器上拥有一个jdk，本实验实现于1.8版本下，如何安装麻烦自行搜索。

3.打卡backup文件夹下面的widget.h文件，将`const QString api = "http://120.55.96.183:5000/";` 后面的ip地址换成你的，同时开放5000端口号。若您的5000端口号已被占用，您可以进入server文件夹下的src文件夹的main文件夹下的resources文件夹，打开`application.properties`文件，将`server.port`设置为您对应的端口号，之后将该文件打成jar包（这一步在IDEA下面进行clean和package操作即可在target目录下产生对应的jar包，可自行搜索对应的方式），之后重新执行第一步。

## 1.若有QT_Creator开发工具

### 1.1采用图形化界面

打开文件夹backup下面的backup.pro文件，导入完整项目，点击运行按钮（或按ctrl+R）执行该项目。

### 1.2采用命令行（前提需要有qt的环境）

打开文件夹backup下面的build.bat文件，在点击运行之前，需要把环境变量改成您的环境变量，内容如下，其中#号注释的下一行需要将路径设置为您的路径

```
#编辑器所在的文件夹
set QTDIR=D:\dev_tools\QT_Creator\5.15.2
set QMAKESPEC=win32-g++
#qmake指令所在的文件夹
set QT_BIN=D:\dev_tools\QT_Creator\5.15.2\mingw81_32\bin
#make指令所在的文件夹
set QT_BIN_TOOLS=D:\dev_tools\QT_Creator\Tools\mingw810_32\bin\
set PATH=C:\WINDOWS\System32
set PATH=%PATH%;%QT_BIN%;%QT_BIN_TOOLS%
qmake -v
qmake backup.pro

if exist release (
rd /s /q release
)

md release
mingw32-make -j8

cd release 
start /b backup.exe 
cd ..\
```

## 2.若无Qt_Creator开发工具

### 2.1.进入backup-release文件

该文件已经打包好，点击backup.exe文件，即可运行文件

### 2.2.点击backupup.exe文件即可安装该软件

该软件已经采用innosetup打包，打包脚本为backup.iss文件，已将其放入项目中。