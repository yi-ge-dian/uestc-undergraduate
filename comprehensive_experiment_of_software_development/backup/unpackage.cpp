#include "unpackage.h"
#include "utils.h"
Unpackage::Unpackage()
{

}

DWORD Unpackage::ShowFileTime(PFILETIME lptime)
{
    FILETIME ftLocal;
    SYSTEMTIME st;
    FileTimeToLocalFileTime(lptime,&ftLocal);
    FileTimeToSystemTime(&ftLocal,&st);
    qDebug() << st.wYear << "/" << st.wMonth << "/" << st.wDay << " " << st.wHour << ":" << st.wMinute << ":" << st.wSecond;
    return 0;
}

DWORD Unpackage::ShowFileAttributes(LPSTR szPath)
{
    //文件属性结构
    WIN32_FILE_ATTRIBUTE_DATA wfad;
    //获取文件属性
    if(!GetFileAttributesExA(szPath,GetFileExInfoStandard, &wfad)){
        qDebug() << "获取文件属性错误：" << GetLastError();
        return 1;
    }
    HANDLE hFile=CreateFileA(szPath,FILE_WRITE_ATTRIBUTES, FILE_SHARE_READ | FILE_SHARE_WRITE, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
    if(hFile!=INVALID_HANDLE_VALUE){
        fileCreatedTime.dwLowDateTime=fileCreatedTime_dwLowDateTime;
        fileCreatedTime.dwHighDateTime=fileCreatedTime_dwHighDateTime;
        fileWrittenTime.dwLowDateTime=fileWrittenTime_dwLowDateTime;
        fileWrittenTime.dwHighDateTime=fileWrittenTime_dwHighDateTime;
        fileAccessedTime.dwLowDateTime=fileAccessedTime_dwLowDateTime;
        fileAccessedTime.dwHighDateTime=fileAccessedTime_dwHighDateTime;
        //设置文件时间
        SetFileTime(hFile, &fileCreatedTime, &fileAccessedTime, &fileWrittenTime);
    }
    CloseHandle(hFile);
    return 0;
}

int Unpackage::unPackage(QString tarFilename, QString destination) {
    QFile tar(tarFilename);
    bool success = tar.open(QFile::ReadOnly);
    if (!success) return 1;
    //相对路径
    QString relativePath;
    //读取文件
    while (tar.read((char*)&relativePathLength, sizeof (relativePathLength))) {
        char* _relativePath = new char[relativePathLength + 1];
        tar.read(_relativePath, relativePathLength);
        _relativePath[relativePathLength] = '\0';
        relativePath = QString::fromStdString(std::string(_relativePath));
        delete[] _relativePath;
        //获得相对路径
        qDebug() << relativePath;
        //读是否为文件
        tar.read((char*)&isFileDictionary, sizeof (isFileDictionary));
        //读文件长度
        tar.read((char*)&fileLength, sizeof (fileLength));
        qDebug() << fileLength;

        if (!isFileDictionary){//如果不是文件夹
            QFile data(destination + "/" + relativePath);
            bool success = data.open(QFile::WriteOnly);
            if (!success) return 2;
            //获得文件创建时间，修改时间，访问时间
            char buffer[12]{'\0'};
            tar.read(buffer,12);
            fileCreatedTime_dwLowDateTime=charArrayToDword(buffer);
            tar.read(buffer,12);
            fileCreatedTime_dwHighDateTime=charArrayToDword(buffer);
            tar.read(buffer,12);
            fileAccessedTime_dwLowDateTime=charArrayToDword(buffer);
            tar.read(buffer,12);
            fileAccessedTime_dwHighDateTime=charArrayToDword(buffer);
            tar.read(buffer,12);
            fileWrittenTime_dwLowDateTime=charArrayToDword(buffer);
            tar.read(buffer,12);
            fileWrittenTime_dwHighDateTime=charArrayToDword(buffer);

            QString absolutePath=destination +  relativePath;

            //变成Windows下面的路径
            QString tempabsolutePath="";
            int i=0;
            while (i<absolutePath.length()) {
                if(absolutePath[i]=="/"){
                    tempabsolutePath.append("\\");
                }else{
                    tempabsolutePath.append(absolutePath[i]);
                }
                i++;
            }
            qDebug()<<tempabsolutePath;

            if (fileLength) {
                char* content = new char[fileLength];
                tar.read(content, fileLength);
                data.write(content, fileLength);
                delete[] content;
            } else {
                data.write("");
            }
            data.close();
            //来这里设置时间
            LPSTR s = const_cast<char *>(tempabsolutePath.toStdString().c_str());
            ShowFileAttributes(s);
        } else {
            QDir dir;
            if (QFileInfo(destination + "/" + relativePath).exists()) continue;
            bool success = dir.mkdir(destination + "/" + relativePath);
            if (!success) return 3;
        }

    }

    return 0;
}


