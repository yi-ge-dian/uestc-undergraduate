#ifndef TASK_H
#define TASK_H
#include <QWidget>
#include <QList>
#include <QDateTime>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QFileInfo>

class Task
{
private:
    QList<QString> files;
    QString backupFilename;
    QString password;
    bool cloud;
    QDateTime currentTime;
    bool operator == (const Task& t) const {
        return files == t.files &&
                backupFilename == t.backupFilename &&
                password == t.password&&
                cloud == t.cloud &&
                currentTime == t.currentTime;
    }


public:
   Task();
   Task(QList<QString> _files, QString _backupFilename, QString _password, bool _cloud, QDateTime _currentTime);

   const QList<QString> &getFiles() const;
   const QString &getBackupFilename() const;
   const QString &getPassword() const;
   bool getCloud() const;
   const QDateTime &getCurrentTime() const;


};
#endif // TASK_H
