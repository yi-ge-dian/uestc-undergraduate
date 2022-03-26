1.实验报告word版在本级目录。

2.实验报告pdf版本在本级目录

3.实验源代码在game文件夹下面。

- exe文件为可执行文件

- 若出现以下情况：

  碰到了缺少ucrtbased.dll文件的情况

  碰到了缺少vcruntime140.dll文件的情况

你可以进入`the file you need`文件夹下面，将其拷贝到`C:\Windows\SysWOW64`(64位系统)或者`C:\Windows\System32`（32位系统）

点击“开始菜单”，选择“运行”按钮，输入：regsvr32 vcruntime140d.dll，点击确定。

点击“开始菜单”，选择“运行”按钮，输入：regsvr32 ucrtbased.dll，点击确定。

若还是不行，搜索cmd，以管理员命令打开，之后再次输入上面的命令（可能需要输入ddl文件的路径哦）