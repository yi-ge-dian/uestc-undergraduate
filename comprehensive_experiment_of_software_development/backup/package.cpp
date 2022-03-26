#include "package.h"
#include "cstdlib"
#include "tchar.h"
#include "utils.h"

Package::Package()
{

}

DWORD Package::ShowFileTime(PFILETIME lptime)
{
    FILETIME ftLocal;
    SYSTEMTIME st;
    FileTimeToLocalFileTime(lptime,&ftLocal);
    FileTimeToSystemTime(&ftLocal,&st);
    qDebug() << st.wYear << "/" << st.wMonth << "/" << st.wDay << " " << st.wHour << ":" << st.wMinute << ":" << st.wSecond;
    return 0;
}

DWORD Package::ShowFileAttributes(LPSTR szPath)
{
    //文件属性结构
    WIN32_FILE_ATTRIBUTE_DATA wfad;
    qDebug() << "文件： " << szPath;
    //获取文件属性
    if(!GetFileAttributesExA(szPath,GetFileExInfoStandard, &wfad)){
        qDebug() << "获取文件属性错误：" << GetLastError();
        return 1;
    }
    //显示相关时间
    qDebug() << "创建时间：\t";
    ShowFileTime(&(wfad.ftCreationTime));
    fileCreatedTime_dwLowDateTime=wfad.ftCreationTime.dwLowDateTime;
    fileCreatedTime_dwHighDateTime=wfad.ftCreationTime.dwHighDateTime;
    qDebug() << "最后访问时间：\t";
    ShowFileTime(&(wfad.ftLastAccessTime));
    fileAccessedTime_dwLowDateTime=wfad.ftLastAccessTime.dwLowDateTime;
    fileAccessedTime_dwHighDateTime=wfad.ftLastAccessTime.dwHighDateTime;
    qDebug() << "最后修改时间：\t";
    ShowFileTime(&(wfad.ftLastWriteTime));
    fileWrittenTime_dwLowDateTime=wfad.ftLastWriteTime.dwLowDateTime;
    fileWrittenTime_dwHighDateTime=wfad.ftLastWriteTime.dwHighDateTime;
    return 0;
}


int Package::package(QStringList files, QString destination)
{
    //目标tar文件
    QFile tar(destination);
    bool success = tar.open(QFile::WriteOnly);
    if (!success) return 1;
    //根路径
    auto root = QFileInfo(files[0]).path();
    for (auto& file : files) {
        if (QFileInfo(file).isFile()) {//如果是文件
            auto relativePath = QString(file).replace(root, "");
            relativePathLength = relativePath.length();
            //写入相对路径
            tar.write((const char*)&relativePathLength, sizeof (relativePathLength));
            tar.write(relativePath.toStdString().c_str());
            fileLength = QFileInfo(file).size();
            isFileDictionary = 0;

            QString absolutePath=root+relativePath;

            qDebug()<<absolutePath;
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

            LPSTR s = const_cast<char *>(tempabsolutePath.toStdString().c_str());
            ShowFileAttributes(s);

            //写入是否为文件
            tar.write((const char*)&isFileDictionary, sizeof (isFileDictionary));
            //写入文件长度目录
            tar.write((const char*)&fileLength, sizeof (fileLength));
            //写入创建时间
            auto temp1=dwordToCharArray(fileCreatedTime_dwLowDateTime);
            tar.write(temp1,12);
            delete []temp1;
            temp1=dwordToCharArray(fileCreatedTime_dwHighDateTime);
            tar.write(temp1,12);
            delete []temp1;

            //写入访问时间
            temp1=dwordToCharArray(fileAccessedTime_dwLowDateTime);
            tar.write(temp1,12);
            delete []temp1;
            temp1=dwordToCharArray(fileAccessedTime_dwHighDateTime);
            tar.write(temp1,12);
            delete []temp1;

            //写入修改时间
            temp1=dwordToCharArray(fileWrittenTime_dwLowDateTime);
            tar.write(temp1,12);
            delete []temp1;
            temp1=dwordToCharArray(fileWrittenTime_dwHighDateTime);
            tar.write(temp1,12);
            delete []temp1;

            QFile data(file);
            bool success = data.open(QFile::ReadOnly);
            if (!success) return 2;
            tar.write(data.readAll());
            data.close();
        } else { //如果是目录
            QDirIterator iter(file, QDirIterator::Subdirectories);
            while (iter.hasNext()) {
                iter.next();
                QFileInfo info = iter.fileInfo();
                if (info.fileName() == "..") continue;
                if (info.isDir()) {//如果是文件夹
                    auto relativePath = QString(info.absoluteFilePath()).replace(root, "");
                    relativePathLength = relativePath.length();
                    //写入相对路径
                    tar.write((const char*)&relativePathLength, sizeof (relativePathLength));
                    tar.write(relativePath.toStdString().c_str());
                    fileLength = 0;
                    isFileDictionary = 1;
                    //写入文件是否为目录
                    tar.write((const char*)&isFileDictionary, sizeof (isFileDictionary));
                    //写入文件长度
                    tar.write((const char*)&fileLength, sizeof (fileLength));
                } else {//如果是文件
                    auto relativePath = QString(info.absoluteFilePath()).replace(root, "");
                    relativePathLength = relativePath.length();
                    //写入相对路径
                    tar.write((const char*)&relativePathLength, sizeof (relativePathLength));
                    tar.write(relativePath.toStdString().c_str());
                    fileLength = info.size();
                    isFileDictionary = 0;
                    QString absolutePath=root+relativePath;

                    qDebug()<<absolutePath;
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

                    LPSTR s = const_cast<char *>(tempabsolutePath.toStdString().c_str());
                    ShowFileAttributes(s);
                    //写入文件长度目录
                    tar.write((const char*)&isFileDictionary, sizeof (isFileDictionary));
                    //写入文件长度
                    tar.write((const char*)&fileLength, sizeof (fileLength));
                    //写入创建时间
                    auto temp1=dwordToCharArray(fileCreatedTime_dwLowDateTime);
                    tar.write(temp1,12);
                    delete []temp1;
                    temp1=dwordToCharArray(fileCreatedTime_dwHighDateTime);
                    tar.write(temp1,12);
                    delete []temp1;

                    //写入访问时间
                    temp1=dwordToCharArray(fileAccessedTime_dwLowDateTime);
                    tar.write(temp1,12);
                    delete []temp1;
                    temp1=dwordToCharArray(fileAccessedTime_dwHighDateTime);
                    tar.write(temp1,12);
                    delete []temp1;

                    //写入修改时间
                    temp1=dwordToCharArray(fileWrittenTime_dwLowDateTime);
                    tar.write(temp1,12);
                    delete []temp1;
                    temp1=dwordToCharArray(fileWrittenTime_dwHighDateTime);
                    tar.write(temp1,12);
                    delete []temp1;

                    QFile data(info.absoluteFilePath());
                    bool success = data.open(QFile::ReadOnly);
                    if (!success) return 2;
                    tar.write(data.readAll());
                    data.close();
                }
            }
        }
    }

    tar.close();

    return 0;
}

