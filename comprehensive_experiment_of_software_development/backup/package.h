#ifndef PACKAGE_H
#define PACKAGE_H
#include <QDirIterator>
#include <QFileInfo>
#include <QDateTime>
#include <QDebug>
#include <windows.h>


class Package
{
private:

    int relativePathLength;//文件相对路径长度
    int fileLength;//文件长度
    bool isFileDictionary;//是否为文件


public:
    Package();

    int package(QStringList files, QString destination);

    LPCWSTR MultiCharToUniChar(char* mbString);
    DWORD ShowFileTime(PFILETIME lptime);
    DWORD ShowFileAttributes(LPSTR szPath);

    FILE fileCreatedTime;
    DWORD fileCreatedTime_dwLowDateTime;
    DWORD fileCreatedTime_dwHighDateTime;
    FILETIME fileAccessedTime;
    DWORD fileAccessedTime_dwLowDateTime;
    DWORD fileAccessedTime_dwHighDateTime;
    FILETIME fileWrittenTime;
    DWORD fileWrittenTime_dwLowDateTime;
    DWORD fileWrittenTime_dwHighDateTime;
};

#endif // PACKAGE_H
