#ifndef UNPACKAGE_H
#define UNPACKAGE_H
#include <QDirIterator>
#include <QFileInfo>
#include <QDebug>
#include <windows.h>


class Unpackage
{

private:
    int relativePathLength;//文件相对路径长度
    int fileLength;//文件长度
    bool isFileDictionary;//是否为文件


    FILETIME fileCreatedTime;
    DWORD fileCreatedTime_dwLowDateTime;
    DWORD fileCreatedTime_dwHighDateTime;
    FILETIME fileAccessedTime;
    DWORD fileAccessedTime_dwLowDateTime;
    DWORD fileAccessedTime_dwHighDateTime;
    FILETIME fileWrittenTime;
    DWORD fileWrittenTime_dwLowDateTime;
    DWORD fileWrittenTime_dwHighDateTime;
public:
    Unpackage();
    int unPackage(QString tarFilename, QString destination);
    DWORD ShowFileAttributes(LPSTR szPath);
    DWORD ShowFileTime(PFILETIME lptime);
};
#endif // UNPACKAGE_H
