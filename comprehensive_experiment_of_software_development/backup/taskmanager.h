#ifndef TASKMANAGER_H
#define TASKMANAGER_H
#include <task.h>

class TaskManager {

private:

  QList<Task> taskList;
  QJsonDocument config;

public:

  TaskManager();
  void init();
  void addTask(Task task);
  void removeTask(int index);
  void clear();
  const QList<Task>& getTaskList();
  void writeJson();
};

#endif // TASKMANAGER_H
