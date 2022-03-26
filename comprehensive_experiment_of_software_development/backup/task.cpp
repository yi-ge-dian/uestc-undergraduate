#include "task.h"

const QList<QString> &Task::getFiles() const
{
    return files;
}

const QString &Task::getBackupFilename() const
{
    return backupFilename;
}


const QString &Task::getPassword() const
{
    return password;
}

bool Task::getCloud() const
{
    return cloud;
}

const QDateTime &Task::getCurrentTime() const
{
    return currentTime;
}

Task::Task(QList<QString> _files, QString _backupFilename, QString _password, bool _cloud, QDateTime _currentTime):
    files(_files),
    backupFilename(_backupFilename),
    password(_password),
    cloud(_cloud),
    currentTime(_currentTime)
{

}


