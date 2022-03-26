#ifndef UTIL_H
#define UTIL_H
#include <QDateTime>
#include <QString>

#include "time.h"
#ifdef _WIN32
#include "sys/utime.h"
#else
#include "utime.h"
#endif

int modifyLastModifyTime(QDateTime LastModifyTime, QString FilePathName){

    if(FilePathName.isEmpty() || !LastModifyTime.isValid() || LastModifyTime.isNull())
        return -1;

    int aYear = LastModifyTime.date().year()-1900;
    int aMonth = LastModifyTime.date().month()-1;
    int aDay = LastModifyTime.date().day();
    int aHour = LastModifyTime.time().hour();
    int aMinute = LastModifyTime.time().minute();
    int aSec = LastModifyTime.time().second();

    struct tm tma = {0};
    tma.tm_year = aYear;
    tma.tm_mon = aMonth;
    tma.tm_mday = aDay;
    tma.tm_hour = aHour;
    tma.tm_min = aMinute;
    tma.tm_sec = aSec;
    tma.tm_isdst = 0;

#ifdef _WIN32
    struct _utimbuf ut;
#else

    struct utimbuf ut;

#endif

    //二者得同修修改，否则修改不成功

    ut.modtime = mktime(&tma);// 最后修改时间
    ut.actime=mktime(&tma);//最后访问时间

    QByteArray ary=FilePathName.toLocal8Bit();
    char *fileName = ary.data();
    int result=-1;

#ifdef _WIN32
    result=_utime(fileName, &ut );
#else

    result=utime(fileName, &ut );

#endif
    return result;//-1表示修改失败
}

#endif // UTIL_H
