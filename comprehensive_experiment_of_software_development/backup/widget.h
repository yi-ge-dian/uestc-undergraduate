#ifndef WIDGET_H
#define WIDGET_H

#include <QWidget>
#include <QMouseEvent>
#include <QLabel>
#include <QPushButton>
#include <QMenu>
#include <QTreeWidgetItem>
#include <QDesktopServices>
#include <taskmanager.h>
#include <backupscheme.h>
#include <QTimer>
#include <QDialog>



QT_BEGIN_NAMESPACE

const QString api = "http://120.55.96.183:5000/";

namespace Ui { class Widget; }
QT_END_NAMESPACE

class Widget : public QWidget
{
    Q_OBJECT

public:
    Widget(QWidget *parent = nullptr);
    ~Widget();
    void mousePressEvent(QMouseEvent *event) override;
    void mouseMoveEvent(QMouseEvent *event) override;

    void ShowImg(QLabel *pLabel, QString path);
    void SetBtnImage(QPushButton *pBtn, QString path);
    void UpdateStackedWidget(int index);

    void UiInit();
    void MainConnect();
    void Page1Connet();
    void Page2Connet();
    void Page3Connet();

    void updateTaskList();
    void updateCloudFileList();


private slots:

    //Page3
    void DeleteTaskButton_clicked();
    void ClearTaskButton_clicked();

    //Page2
    void LocalGroupBox_clicked(bool checked);
    void CloudGroupBox_clicked(bool checked);
    void BrowseRestoreDirectoryButton_clicked();
    void PasswordCheckBox_2_stateChanged(bool checked);
    void receiveData(QString password,bool cloudCheckFlag,bool passwordCheckFlag);
    void StartRestoreButton_clicked();
    void on_cloudFileList_currentItemChanged(QTreeWidgetItem* current, QTreeWidgetItem* previous);
    void DeleteCloudBackupFileButton_clicked();
    void ClearCloudBackupFileButton_clicked();
    void CheckButton_clicked();

    //page1
    void BackupSchemeButton_clicked();
    void DeleteFileButton_clicked();
    void ClearFileButton_clicked();
    void AddFileButton_clicked();
    void AddDirectoryButton_clicked();
    void BrowseLocalFile_clicked();
    void BrowseButton_clicked();
    void StartBackupButton_clicked();



    void on_taskList_itemClicked(QTreeWidgetItem *item, int column);

private:
    Ui::Widget *ui;
    BackupScheme  *backupSchemeDialog;

    QPoint m_WindowsPos;
    QPoint m_MousePos;
    QPoint m_dPos;

    TaskManager *taskManager;

    QMenu* popMenu;
    QAction* openFolder;
    QAction* removeCloudBackupFile;
    QAction* check;

    QString password;
    bool cloudCheckFlag;
    bool passwordCheckFlag;

    QTimer *timer;


};
#endif // WIDGET_H
