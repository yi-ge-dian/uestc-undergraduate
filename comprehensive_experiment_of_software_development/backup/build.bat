set QTDIR=D:\dev_tools\QT_Creator\5.15.2
set QMAKESPEC=win32-g++
set QT_BIN=D:\dev_tools\QT_Creator\5.15.2\mingw81_32\bin
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
