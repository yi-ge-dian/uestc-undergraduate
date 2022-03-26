QT       += core gui
QT       += network

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    backupscheme.cpp \
    compressor.cpp \
    decompressor.cpp \
    main.cpp \
    md5.cpp \
    package.cpp \
    task.cpp \
    taskmanager.cpp \
    unpackage.cpp \
    widget.cpp

HEADERS += \
    backupscheme.h \
    check.h \
    compressor.h \
    decompressor.h \
    md5.h \
    package.h \
    task.h \
    taskmanager.h \
    unpackage.h \
    utils.h \
    widget.h

FORMS += \
    backupscheme.ui \
    widget.ui

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

RESOURCES += \
    res.qrc

DISTFILES += \
    pictures/backup.ico
