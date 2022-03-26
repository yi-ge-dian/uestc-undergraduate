#include "taskmanager.h"
#include "task.h"
#include <QDebug>

TaskManager::TaskManager()
{

}
//任务初始化
void TaskManager::init() {
    if (QFileInfo("config.json").exists()) {
        QFile file("config.json");
        file.open(QFile::ReadWrite);
        config = QJsonDocument::fromJson(file.readAll());
        file.close();
        QJsonArray tasks = config.array();
        for (auto task : tasks) {
            auto information = task.toObject();
            QList<QString> files;
            for (auto file : information["files"].toArray()) {
                files.append(file.toString());
            }
            taskList.append(Task(files,
                                 information["backupFilename"].toString(),
                                 information["password"].toString(),
                                 information["cloud"].toBool(),
                                 QDateTime::fromString(information["currentTime"].toString("yyyy-MM-dd hh:mm:ss"))));
        }
    } else {
        QFile file("config.json");
        file.open(QFile::WriteOnly);
        file.write("");
        file.close();
    }
}


//增加任务列表
void TaskManager::addTask(Task task) {
    taskList.append(task);
    writeJson();
}


//获得任务列表
const QList<Task> &TaskManager::getTaskList()
{
    return taskList;
}

//删除任务列表
void TaskManager::removeTask(int index) {
    taskList.removeAt(index);
    writeJson();
}

//写json文件
void TaskManager::writeJson() {
    QFile file("config.json");
    file.open(QFile::WriteOnly);
    QJsonArray tasks;
    for (auto task : taskList) {
        QJsonObject information;
        QJsonArray files;
        for (auto file : task.getFiles()) {
            files.append(file);
        }
        information["files"] = files;
        information["backupFilename"] = task.getBackupFilename();
        information["password"] = task.getPassword();
        information["cloud"] = task.getCloud();
        information["currentTime"] = task.getCurrentTime().toString();
        tasks.append(information);
    }
    file.write(QJsonDocument(tasks).toJson());
    file.close();
}

//清空任务列表
void TaskManager::clear() {
    taskList.clear();
    QFile file("config.json");
    file.open(QFile::WriteOnly);
    file.write("");
    file.close();
}
