#pragma execution_character_set("utf-8")

#include "widget.h"
#include "ui_widget.h"
#include "taskmanager.h"
#include "check.h"
#include "package.h"
#include "unpackage.h"
#include "compressor.h"
#include "decompressor.h"
#include "regex"
#include <QMessageBox>
#include <QFileDialog>
#include <QFileInfo>
#include <QProcess>
#include <QtNetwork/QNetworkAccessManager>
#include <QtNetwork/QNetworkRequest>
#include <QtNetwork/QNetworkReply>


Widget::Widget(QWidget *parent)
    : QWidget(parent)
    , ui(new Ui::Widget)
{
    ui->setupUi(this);
    //UI初始化
    UiInit();
    //首页信号槽连接函数
    MainConnect();
    //分页i信号槽连接函数
    Page1Connet();
    Page2Connet();
    Page3Connet();
}

Widget::~Widget()
{
    delete ui;
    ClearFileButton_clicked();
}


//UI初始化
void Widget::UiInit()
{
    //显示logo
    ShowImg(ui->labelLogo, ":/img/pictures/LOGO.png");
    //显示主界面
    ShowImg(ui->label0, ":/img/pictures/1.png");
    //显示button
    SetBtnImage(ui->btnGit, ":/img/pictures/menu.png");
    SetBtnImage(ui->btnMin, ":/img/pictures/mini.png");
    SetBtnImage(ui->btnClose, ":/img/pictures/close.png");
    int wid = ui->listWidget->width();
    int hig = (ui->listWidget->height() - 120) / 4;
    //去掉边框
    this->setWindowFlag(Qt::FramelessWindowHint);
    //固定窗口大小
    this->setFixedSize(this->width(), this->height());
    //任务列表界面列宽度设定
    ui->taskList->setColumnWidth(0,100);
    ui->taskList->setColumnWidth(1,150);
    ui->taskList->setColumnWidth(2,100);
    ui->taskList->setColumnWidth(3,50);
    ui->taskList->setColumnWidth(4,200);
    //侧边栏元素添加
    QStringList strList;
    strList << tr("首页") << tr("备份") << tr("恢复") << tr("日志");
    for(int i = 0; i< strList.size(); i++)
    {
        QListWidgetItem *pItem = new QListWidgetItem;
        pItem->setSizeHint(QSize(wid, hig));
        pItem->setText(strList.at(i));
        pItem->setTextAlignment(Qt::AlignCenter);
        ui->listWidget->insertItem(i, pItem);
    }
    //使 localGroupBox 可用而 cloudGroupBox不可用
    CloudGroupBox_clicked(true);
    LocalGroupBox_clicked(true);
    //使 password2Box不可用
    PasswordCheckBox_2_stateChanged(false);
    //默认不使用密码加密方式
    passwordCheckFlag=false;
    //默认密码为空
    password="";
    //默认不使用上传到云端
    cloudCheckFlag=false;
    //初始化taskManager
    taskManager=new TaskManager();
    taskManager->init();
    updateTaskList();
}
//设置按钮图片
void Widget::SetBtnImage(QPushButton *pBtn, QString path)
{
    QPixmap pix(path);
    int wid = 35;
    pix.scaled(wid,wid,Qt::IgnoreAspectRatio, Qt::SmoothTransformation);
    pBtn->setIcon(QIcon(pix));
    pBtn->setIconSize(QSize(wid, wid));
    pBtn->setFlat(true);
    pBtn->setStyleSheet("border:1px");
}
//根据路径加载图片
void Widget::ShowImg(QLabel *pLabel, QString path)
{
    QPixmap *pix = new QPixmap(path);
    pix->scaled(pLabel->size(), Qt::KeepAspectRatio);
    pLabel->setScaledContents(true);
    pLabel->setPixmap(*pix);
}
//鼠标按压事件
void Widget::mousePressEvent(QMouseEvent *event){
    m_WindowsPos=this->pos();
    m_MousePos=event->globalPos();
    m_dPos=m_MousePos-m_WindowsPos;
}
//鼠标点击事件
void Widget::mouseMoveEvent(QMouseEvent *event) {
    this->move(event->globalPos()-m_dPos);
}

//更新任务列表
void Widget::updateTaskList(){
    //遍历taskList
    for (const auto& task : taskManager->getTaskList()) {
        QTreeWidgetItem* taskItem = new QTreeWidgetItem;
        taskItem->setText(0, QFileInfo(task.getBackupFilename()).fileName() + ".bak");
        taskItem->setText(1, task.getCurrentTime().toString());
        taskItem->setText(2, task.getPassword().trimmed() != "" ? "是" : "否");
        taskItem->setText(3, task.getCloud() ? "是" : "否");
        taskItem->setText(4, task.getBackupFilename() + ".bak");
        ui->taskList->addTopLevelItem(taskItem);
    }
    if (!ui->taskList->currentItem() && ui->taskList->topLevelItemCount()) {
        ui->taskList->setCurrentItem(ui->taskList->topLevelItem(0));
    }
}
//更新云端列表
void Widget::updateCloudFileList(){
    QNetworkAccessManager* manager = new QNetworkAccessManager(this);
    QNetworkRequest request(QUrl(api + "filelist"));
    QNetworkReply* reply = manager->get(request);

    connect(manager, &QNetworkAccessManager::finished, this, [=](QNetworkReply * _reply) {
        auto filelist = QJsonDocument::fromJson(_reply->readAll()).array();
        for (auto file : filelist) {
            QTreeWidgetItem* item = new QTreeWidgetItem;
            item->setText(0, file.toString());
            ui->cloudFileList->addTopLevelItem(item);
        }
    });

    connect(reply,QOverload<QNetworkReply::NetworkError>::of(&QNetworkReply::error),this,[=](QNetworkReply::NetworkError code) {
        if (code) {
            QMessageBox::information(this, "提示", "云端列表获取失败。",QMessageBox::Yes, QMessageBox::Yes);
        }
    });
}

//-------------------------------------------------------------------------------Main----------------------------------------------------------------//
//首页信号槽函数连接server-0.0.1-SNAPSHOT.jar
void Widget::MainConnect()
{
    //开发人员槽函数
    connect(ui->btnGit, &QPushButton::clicked, [=]{
        QDesktopServices::openUrl(QUrl("https://github.com/Yi-Ge-Dian/UESTC-Computer-science-and-engineering"));
    });
    //最小化按钮槽函数
    connect(ui->btnMin, &QPushButton::clicked, [=]{
        this->showMinimized();
    });
    //关闭按钮槽函数
    connect(ui->btnClose, &QPushButton::clicked, [=]{
        this->close();
    });
    //listWidget滚动槽函数
    connect(ui->listWidget, &QListWidget::currentRowChanged, [=](int index)
    {
        ui->stackedWidget->setCurrentIndex(index);
    });
    //stackedwidget改变槽函数
    connect(ui->stackedWidget, &QStackedWidget::currentChanged, [=](int index){
        UpdateStackedWidget(index);
    });
    //点击备份跳转到备份功能
    connect(ui->btnGlobalBackup,&QPushButton::clicked,[=]{
        ui->stackedWidget->setCurrentIndex(1);
        ui->listWidget->setCurrentRow(1);
    });
    //点击恢复跳转到恢复功能
    connect(ui->btnGlobalRestore,&QPushButton::clicked,[=]{
        ui->stackedWidget->setCurrentIndex(2);
        ui->listWidget->setCurrentRow(2);
    });

}

//更新stackwidget
void Widget::UpdateStackedWidget(int index)
{
    QString url = ":/img/pictures/" + QString::number(index + 1) + ".png";
    switch (index) {
    case 0: ShowImg(ui->label0, url);
        break;
    case 1:ShowImg(ui->label1, url);
        break;
    case 2:ShowImg(ui->label2, url);
        break;
    case 3:ShowImg(ui->label3, url);
        break;
    default:
        break;
    }
}

//-------------------------------------------------------Page1----------------------------------------------------------//

//Page1信号槽函数连接信号
void Widget::Page1Connet(){
    //备份方案信号槽连接
    connect(ui->backupSchemeButton,&QToolButton::clicked,[=]{
        BackupSchemeButton_clicked();

    });
    //清空信号槽函数连接
    connect(ui->clearFileButton,&QToolButton::clicked,[=]{
        ClearFileButton_clicked();
    });
    //浏览备份到的文件槽函数连接
    connect(ui->browseButton,&QToolButton::clicked,[=]{
        BrowseButton_clicked();
    });
    //添加文件槽函数连接
    connect(ui->addFileButton,&QToolButton::clicked,[=]{
        AddFileButton_clicked();
    });
    //删除文件槽函数连接
    connect(ui->deleteFileButton,&QToolButton::clicked,[=]{
        DeleteFileButton_clicked();
    });
    //添加文件夹槽函数连接
    connect(ui->addDirectoryButton,&QToolButton::clicked,[=]{
        AddDirectoryButton_clicked();
    });
    //开始备份槽函数连接
    connect(ui->startBackupButton,&QToolButton::clicked,[=]{
        StartBackupButton_clicked();
    });


}


//备份方案按钮点击事件
void Widget::BackupSchemeButton_clicked()
{
    backupSchemeDialog =new BackupScheme(this);
    backupSchemeDialog->setWindowTitle("备份方案");
    backupSchemeDialog->PasswordCheckBox_stateChanged();
    connect(backupSchemeDialog,SIGNAL(sendData(QString,bool,bool)),this,SLOT(receiveData(QString,bool,bool)));
    backupSchemeDialog->exec();
    delete backupSchemeDialog;
}

//接受QDialog的信号
void Widget::receiveData(QString password,bool cloudCheckFlag,bool passwordCheckFlag){
    this->password=password;
    this->cloudCheckFlag=cloudCheckFlag;
    this->passwordCheckFlag=passwordCheckFlag;
}

//清空文件按钮点击事件
void Widget::ClearFileButton_clicked() {
    while (ui->backupFileList->currentItem()) {
        delete ui->backupFileList->currentItem();
    }
}
//浏览备份到的文件点击事件
void Widget::BrowseButton_clicked() {
    QString directory = QFileDialog::getExistingDirectory(
                this,
                tr("备份到"),
                "/home",
                QFileDialog::ShowDirsOnly | QFileDialog::DontResolveSymlinks);
    if (directory != "") {
        ui->backupFileDirectoryLineEdit->setText(directory);
    }
}
//添加文件按钮点击事件
void Widget::AddFileButton_clicked() {
    QStringList files = QFileDialog::getOpenFileNames(
                this,
                "选择一个或多个文件",
                "/home",
                "所有文件 (*.*)");
    for (const auto& file : files) {
        // 去重
        bool duplication = false;
        for (int i = 0; i < ui->backupFileList->topLevelItemCount(); ++i) {
            if (ui->backupFileList->topLevelItem(i)->text(1) == file) {
                duplication = true;
                break;
            }
        }
        if (duplication) continue;

        QTreeWidgetItem* fileItem = new QTreeWidgetItem;
        fileItem->setText(0, QFileInfo(file).fileName());
        fileItem->setText(1, file);
        ui->backupFileList->addTopLevelItem(fileItem);
    }

    if (!ui->backupFileList->currentItem() && ui->backupFileList->topLevelItemCount()) {
        ui->backupFileList->setCurrentItem(ui->backupFileList->topLevelItem(0));
    }
}
//删除文件按钮点击事件
void Widget::DeleteFileButton_clicked() {
    if (ui->backupFileList->currentItem()) {
        delete ui->backupFileList->currentItem();
    }
}
//添加文件夹按钮点击事件
void Widget::AddDirectoryButton_clicked(){
    QString directory = QFileDialog::getExistingDirectory(
                this,
                tr("选择一个文件夹"),
                "/home",
                QFileDialog::ShowDirsOnly | QFileDialog::DontResolveSymlinks);
    if (directory != "") {
        // 去重
        for (int i = 0; i < ui->backupFileList->topLevelItemCount(); ++i) {
            if (ui->backupFileList->topLevelItem(i)->text(1) == directory) return;
        }
        QTreeWidgetItem* fileItem = new QTreeWidgetItem;
        fileItem->setText(0, QFileInfo(directory).fileName());
        fileItem->setText(1, directory);
        ui->backupFileList->addTopLevelItem(fileItem);
    }

    if (!ui->backupFileList->currentItem() && ui->backupFileList->topLevelItemCount()) {
        ui->backupFileList->setCurrentItem(ui->backupFileList->topLevelItem(0));
    }

}
//开始备份按钮点击事件
void Widget::StartBackupButton_clicked() {
    if (!ui->backupFileList->topLevelItemCount()) {
        QMessageBox::information(this, "提示", "请添加需要备份的文件。",QMessageBox::Yes, QMessageBox::Yes);
        return;
    }
    if (ui->backupFilenameLineEdit->text().trimmed() == "") {
        QMessageBox::information(this, "提示", "请输入备份后的文件名。",QMessageBox::Yes, QMessageBox::Yes);
        return;
    }
    if (ui->backupFileDirectoryLineEdit->text().trimmed() == "") {
        QMessageBox::information(this, "提示", "请输入备份保存到的目录。",QMessageBox::Yes, QMessageBox::Yes);
        return;
    }
    QFileInfo fileinfo(ui->backupFileDirectoryLineEdit->text().trimmed());
    if (!fileinfo.isDir()) {
        QMessageBox::information(this, "提示", "请输入合法的目录。",QMessageBox::Yes, QMessageBox::Yes);
        return;
    }
    std::regex filenameExpress("[\\/:*?\"<>|]");
    if (std::regex_search(ui->backupFilenameLineEdit->text().toStdString(), filenameExpress)) {
        QMessageBox::information(this, "提示", "请输入合法的备份文件名。",QMessageBox::Yes, QMessageBox::Yes);
        return;
    }
    if (QFileInfo(ui->backupFileDirectoryLineEdit->text() + "\\" + ui->backupFilenameLineEdit->text()+".bak").exists()) {
        if (QMessageBox::Yes != QMessageBox::question(this, "警告", "文件已存在于您即将备份的本地目录，确认覆盖？", QMessageBox::Yes | QMessageBox::No)) {
            return;
        }
    }

    for(int i=0;i<ui->cloudFileList->topLevelItemCount();i++){
        if(ui->cloudFileList->topLevelItem(i)->text(0)==ui->backupFilenameLineEdit->text()+".bak"){
            if (QMessageBox::Yes != QMessageBox::question(this, "警告", "文件已存在于您即将备份的服务器目录，确认覆盖？", QMessageBox::Yes | QMessageBox::No)) {
                return;
            }
        }
    }
    if (passwordCheckFlag==true && password.trimmed() == "") {
        QMessageBox::information(this, "提示", "请输入密码。",QMessageBox::Yes, QMessageBox::Yes);
        return;
    }

    // 都与第一个文件的目录对比
    auto rootDirectory = QFileInfo(ui->backupFileList->topLevelItem(0)->text(1)).path();
    for (int i = 1; i < ui->backupFileList->topLevelItemCount(); ++i) {
        if (QFileInfo(ui->backupFileList->topLevelItem(i)->text(1)).path() != rootDirectory) {
            QMessageBox::information(this, "提示", "选择的文件或文件夹应位于同一目录下,若不位于同一目录，请多次进行备份",QMessageBox::Yes, QMessageBox::Yes);
            return;
        }
    }


    //读取文件
    QStringList files;
    for (int i = 0; i < ui->backupFileList->topLevelItemCount(); ++i) {
        files.append(ui->backupFileList->topLevelItem(i)->text(1));
    }

    //打包
    Package *package=new Package;
    int errorCode = package->package(files, ui->backupFilenameLineEdit->text() + ".tar");
    if (errorCode) {
        QStringList message = {"正常执行", "目标文件打开失败", "打开源文件失败"};
        QMessageBox::information(this, "提示", message[errorCode],QMessageBox::Yes, QMessageBox::Yes);
        return;
    }

    //压缩
    Compressor compressor;
    errorCode = compressor.compress(ui->backupFilenameLineEdit->text().toStdString() + ".tar",
                                    ui->backupFileDirectoryLineEdit->text().toStdString() + "/",
                                    passwordCheckFlag? password.toStdString() : "");
    if (errorCode) {
        QStringList message = {"正常执行", "源文件扩展名不是bak", "打开源文件失败", "打开目标文件失败"};
        QMessageBox::information(this, "提示", message[errorCode],QMessageBox::Yes, QMessageBox::Yes);
        return;
    }

    QFile tarFile(ui->backupFilenameLineEdit->text() + ".tar");
    tarFile.remove();

    // 云上传
    if (cloudCheckFlag) {
        QNetworkAccessManager* manager = new QNetworkAccessManager(this);
        QFile uploadFile(ui->backupFileDirectoryLineEdit->text() + "/" + ui->backupFilenameLineEdit->text() + ".bak");
        QNetworkRequest request(QUrl(api + "file/" + ui->backupFilenameLineEdit->text() + ".bak"));
        request.setRawHeader("Content-Type", "application/bak");
        uploadFile.open(QFile::ReadOnly);
        QNetworkReply* reply = manager->put(request, uploadFile.readAll().toBase64());
        uploadFile.close();

        connect(manager, &QNetworkAccessManager::finished, this, [=](QNetworkReply * _reply) {
            if (_reply->readAll().toStdString() == "success") {
                QMessageBox::information(this, "提示", "上传成功。",QMessageBox::Yes, QMessageBox::Yes);
            }
        });

        connect(reply, &QNetworkReply::uploadProgress, this, [](qint64 bytesReceived, qint64 bytesTotal) {
            qDebug() << bytesReceived << "/" << bytesTotal;
        });

        connect(reply,QOverload<QNetworkReply::NetworkError>::of(&QNetworkReply::error),this,[ = ](QNetworkReply::NetworkError code) {
            if (code) {
                QMessageBox::information(this, "提示", "上传失败。",QMessageBox::Yes, QMessageBox::Yes);
            }
        });
        QTreeWidgetItem *item=new QTreeWidgetItem;
        item->setText(0,ui->backupFilenameLineEdit->text()+"."+"bak");
        ui->cloudFileList->addTopLevelItem(item);


        QTreeWidgetItem* taskItem = new QTreeWidgetItem;
        QDateTime datetime1(QDateTime::currentDateTime());

        taskItem->setText(0, ui->backupFilenameLineEdit->text()+ ".bak");
        taskItem->setText(1, datetime1.toString("yyyy-MM-dd hh:mm:ss"));
        taskItem->setText(2, password.trimmed() != "" ? "是" : "否");
        taskItem->setText(3, "是");
        taskItem->setText(4,  "/root/backup/"+ui->backupFilenameLineEdit->text()+ ".bak");
        ui->taskList->addTopLevelItem(taskItem);
        taskManager->addTask(Task(files,
                                  "/root/backup/"+ui->backupFilenameLineEdit->text(),
                                  password,
                                  true,
                                  datetime1));
    }else {
        QMessageBox::information(this, "提示", "备份成功。",QMessageBox::Yes, QMessageBox::Yes);
    }
    QDateTime datetime2(QDateTime::currentDateTime());
    QTreeWidgetItem* taskItem2 = new QTreeWidgetItem;
    taskItem2->setText(0, ui->backupFilenameLineEdit->text()+ ".bak");
    taskItem2->setText(1, datetime2.toString("yyyy-MM-dd hh:mm:ss"));
    taskItem2->setText(2, password.trimmed() != "" ? "是" : "否");
    taskItem2->setText(3, "否");
    taskItem2->setText(4, ui->backupFileDirectoryLineEdit->text() + "/" +  ui->backupFilenameLineEdit->text() + ".bak");
    ui->taskList->addTopLevelItem(taskItem2);
    taskManager->addTask(Task(files,
                              ui->backupFileDirectoryLineEdit->text() + "/" + ui->backupFilenameLineEdit->text(),
                              password,
                              false,
                              datetime2));
    if (!ui->taskList->currentItem() && ui->taskList->topLevelItemCount()) {
        ui->taskList->setCurrentItem(ui->taskList->topLevelItem(0));
    }
    cloudCheckFlag=false;
    passwordCheckFlag=false;
    password="";
}

//-------------------------------------------------Page2--------------------------------------------------------------------------------------------------------//

//Page2信号槽函数连接信号
void Widget::Page2Connet(){
    //localgroup信号槽函数连接
    connect(ui->localGroupBox,&QGroupBox::clicked,[=](bool check){
        LocalGroupBox_clicked(check);
    });
    //cloudgroup信号槽函数连接
    connect(ui->cloudGroupBox,&QGroupBox::clicked,[=](bool check){
        CloudGroupBox_clicked(check);
    });
    //浏览本地备份文件槽函数连接
    connect(ui->browseLocalFile,&QToolButton::clicked,[=]{
        BrowseLocalFile_clicked();
    });
    //浏览云端备份文件槽函数连接
    connect(ui->browseRestoreDirectoryButton,&QToolButton::clicked,[=]{
        BrowseRestoreDirectoryButton_clicked();
    });
    //password2checxbox状态检测槽函数连接
    connect(ui->passwordCheckBox_2,&QCheckBox::clicked,[=](bool check){
        PasswordCheckBox_2_stateChanged(check);
    });
    //开始还原文件槽函数连接
    connect(ui->startRestoreButton,&QToolButton::clicked,[=](){
        StartRestoreButton_clicked();
    });
    //删除云端备份文件槽函数连接
    connect(ui->deleteCloudBackupFileButton,&QToolButton::clicked,[=](){
        DeleteCloudBackupFileButton_clicked();
    });
    //清空云端备份文件槽函数连接
    connect(ui->clearCloudBackupFileButton,&QToolButton::clicked,[=](){
        ClearCloudBackupFileButton_clicked();
    });


}
//删除云备份按钮点击事件
void Widget::DeleteCloudBackupFileButton_clicked(){
    if (ui->cloudFileList->currentItem()) {
        if (QMessageBox::Yes != QMessageBox::question(this, "警告", "确认删除？", QMessageBox::Yes | QMessageBox::No)) {
            return;
        }
        QNetworkAccessManager* manager = new QNetworkAccessManager(this);
        QNetworkRequest request(QUrl(api + "file/" +ui->cloudFileList->currentItem()->text(0)));
        QNetworkReply* reply = manager->deleteResource(request);
        connect(manager, &QNetworkAccessManager::finished, this, [ = ](QNetworkReply * _reply) {
            if (_reply->readAll().toStdString() == "success") {
                QMessageBox::information(this, "提示", "删除成功。",
                                         QMessageBox::Yes, QMessageBox::Yes);
                QTreeWidgetItem *item=ui->cloudFileList->currentItem();
                delete item;
                if (ui->cloudFileList->topLevelItemCount()) {
                    ui->cloudFileList->setCurrentItem(ui->cloudFileList->topLevelItem(0));
                }
                ui->cloudFileRestoreLineEdit->clear();
            }
        });
        connect(reply,
                QOverload<QNetworkReply::NetworkError>::of(&QNetworkReply::error),
                this,
                [=](QNetworkReply::NetworkError code) {
            if (code) {
                QMessageBox::information(this, "提示", "删除失败。",
                                         QMessageBox::Yes, QMessageBox::Yes);
            }
        });
    }
}

//清空云备份按钮点击事件
void Widget::ClearCloudBackupFileButton_clicked(){
    ui->cloudFileList->setCurrentItem(ui->cloudFileList->topLevelItem(0));
    if(ui->cloudFileList->currentItem()){
        if (QMessageBox::Yes != QMessageBox::question(this, "警告", "确认清空", QMessageBox::Yes | QMessageBox::No)) {
            return;
        }
    }
    int topLevelItemCount=ui->cloudFileList->topLevelItemCount();
    for(int i=topLevelItemCount-1;i>=0;i--){
        QNetworkAccessManager* manager = new QNetworkAccessManager(this);
        QNetworkRequest request(QUrl(api + "file/" +ui->cloudFileList->topLevelItem(i)->text(0)));
        QNetworkReply* reply = manager->deleteResource(request);
        connect(manager, &QNetworkAccessManager::finished, this, [=](QNetworkReply * _reply) {
            if (_reply->readAll().toStdString() == "success") {
                ui->cloudFileList->takeTopLevelItem(i);
            }
        });
        connect(reply,QOverload<QNetworkReply::NetworkError>::of(&QNetworkReply::error),this,[=](QNetworkReply::NetworkError code) {
            if (code) {
                QMessageBox::information(this, "提示", "删除失败。",QMessageBox::Yes, QMessageBox::Yes);
            }
        });
    }
    ui->cloudFileList->clear();
    ui->cloudFileRestoreLineEdit->clear();
    QMessageBox::information(this, "提示", "清空成功。",QMessageBox::Yes, QMessageBox::Yes);

}



//开始恢复按钮点击事件
void Widget::StartRestoreButton_clicked() {
    if (ui->localGroupBox->isChecked() && ui->localFileRestoreLineEdit->text().trimmed() == "") {
        QMessageBox::information(this, "提示", "请选择要恢复的备份文件。",QMessageBox::Yes, QMessageBox::Yes);
        return;
    }
    if (ui->cloudGroupBox->isChecked() && ui->cloudFileRestoreLineEdit->text().trimmed() == "") {
        QMessageBox::information(this, "提示", "请选择要恢复的备份文件。",QMessageBox::Yes, QMessageBox::Yes);
        return;
    }
    if (ui->backupFileRestoreDirectoryLineEdit->text().trimmed() == "") {
        QMessageBox::information(this, "提示", "请选择要恢复到的目录。", QMessageBox::Yes, QMessageBox::Yes);
        return;
    }
    if (ui->passwordCheckBox_2->isChecked() && ui->passwordLineEdit_2->text().trimmed() == "") {
        QMessageBox::information(this, "提示", "请输入密码。",QMessageBox::Yes, QMessageBox::Yes);
        return;
    }
    if (ui->cloudGroupBox->isChecked()){//从云端恢复
        QNetworkAccessManager* manager = new QNetworkAccessManager(this);
        QNetworkRequest request(QUrl(api + "file/" + ui->cloudFileRestoreLineEdit->text()));
        QNetworkReply* reply = manager->get(request);
        connect(manager, &QNetworkAccessManager::finished, this, [=](QNetworkReply * _reply) {
            auto file = QByteArray::fromBase64(_reply->readAll());
            qDebug() << file.size();
            QFile cloudFile("temp_" + ui->cloudFileRestoreLineEdit->text());
            cloudFile.open(QFile::WriteOnly);
            cloudFile.write(file);
            cloudFile.close();
            Decompressor decompressor;
            int errorCode = decompressor.decompress("temp_" + ui->cloudFileRestoreLineEdit->text().toStdString(),
                                                    ui->backupFileRestoreDirectoryLineEdit->text().toStdString() + "/",
                                                    ui->passwordCheckBox_2->isChecked() ? ui->passwordLineEdit_2->text().toStdString() : "");
            if (errorCode) {
                QStringList message = {"正常执行", "源文件扩展名不是bak", "打开源文件失败", "打开目标文件失败", "文件过短，频率表不完整", "文件结尾不完整", "密码错误", "解码错误"};
                QMessageBox::information(this, "提示", message[errorCode],
                                         QMessageBox::Yes, QMessageBox::Yes);
                return;
            }

            cloudFile.remove();

            QString tempFilename = ui->backupFileRestoreDirectoryLineEdit->text() + "/" + "temp_" + ui->cloudFileRestoreLineEdit->text().left(ui->cloudFileRestoreLineEdit->text().length() - 3) + "tar";

            Unpackage *unpackage=new Unpackage();
            errorCode = unpackage->unPackage(tempFilename, ui->backupFileRestoreDirectoryLineEdit->text());
            if (errorCode) {
                QStringList message = {"正常执行",  "打开源文件失败", "目标文件打开失败", "创建目录失败"};
                QMessageBox::information(this, "提示", message[errorCode],QMessageBox::Yes, QMessageBox::Yes);
                return;
            }
            QFile tarFile(tempFilename);
            tarFile.remove();

            QMessageBox::information(this, "提示", "恢复完成。",QMessageBox::Yes, QMessageBox::Yes);
            QDesktopServices::openUrl(QUrl("file:///" + ui->backupFileRestoreDirectoryLineEdit->text(), QUrl::TolerantMode));
        });

        connect(reply,QOverload<QNetworkReply::NetworkError>::of(&QNetworkReply::error),this,[=](QNetworkReply::NetworkError code) {
            if (code) {QMessageBox::information(this, "提示", "云备份下载失败。",QMessageBox::Yes, QMessageBox::Yes);
            }
        });
    }else {//从本地恢复
        Decompressor decompressor;
        int errorCode = decompressor.decompress(ui->localFileRestoreLineEdit->text().toStdString(),
                                                ui->backupFileRestoreDirectoryLineEdit->text().toStdString() + "/",
                                                ui->passwordCheckBox_2->isChecked() ? ui->passwordLineEdit_2->text().toStdString() : "");
        if (errorCode) {
            QStringList message = {"正常执行", "源文件扩展名不是bak", "打开源文件失败", "打开目标文件失败", "文件过短，频率表不完整", "文件结尾不完整", "密码错误", "解码错误"};
            QMessageBox::information(this, "提示", message[errorCode], QMessageBox::Yes, QMessageBox::Yes);
            return;
        }

        QString tempFilename = ui->backupFileRestoreDirectoryLineEdit->text() + "/" + QFileInfo(ui->localFileRestoreLineEdit->text()).fileName();
        tempFilename = tempFilename.left(tempFilename.length() - 3) + "tar";


        Unpackage *unpackage=new Unpackage();
        errorCode = unpackage->unPackage(tempFilename, ui->backupFileRestoreDirectoryLineEdit->text());
        if (errorCode) {
            QStringList message = {"正常执行",  "打开源文件失败", "目标文件打开失败", "创建目录失败"};
            QMessageBox::information(this, "提示", message[errorCode],QMessageBox::Yes, QMessageBox::Yes);
            return;
        }

        QFile tarFile(tempFilename);
        tarFile.remove();

        QMessageBox::information(this, "提示", "恢复完成。", QMessageBox::Yes, QMessageBox::Yes);
        QDesktopServices::openUrl(QUrl("file:///" + ui->backupFileRestoreDirectoryLineEdit->text(), QUrl::TolerantMode));
    }
    password="";

}

void Widget::on_cloudFileList_currentItemChanged(QTreeWidgetItem* current, QTreeWidgetItem* previous) {
    if (current){
        ui->cloudFileRestoreLineEdit->setText(current->text(0));
    }
}

// password2checxbox状态检测函数
void Widget::PasswordCheckBox_2_stateChanged(bool checked) {
    ui->passwordLineEdit_2->setEnabled(checked);
}

//浏览云端备份文件按钮点击事件
void Widget::BrowseRestoreDirectoryButton_clicked() {
    QString directory = QFileDialog::getExistingDirectory(
                this,
                tr("恢复到"),
                "/home",
                QFileDialog::ShowDirsOnly | QFileDialog::DontResolveSymlinks);
    if (directory != "") {
        ui->backupFileRestoreDirectoryLineEdit->setText(directory);
    }
}


//浏览本地备份文件按钮点击事件
void Widget::BrowseLocalFile_clicked() {
    auto file = QFileDialog::getOpenFileName(
                this,
                "选择一个备份文件",
                "",
                "所有文件 (*.*)");
    if (file != "") {
        ui->localFileRestoreLineEdit->setText(file);
    }
}
//本地GroupBox有效
void Widget::LocalGroupBox_clicked(bool checked)
{
    ui->localGroupBox->setChecked(checked);
    ui->cloudGroupBox->setChecked(!checked);
}

//云端GroupBox有效
void Widget::CloudGroupBox_clicked(bool checked) {
    ui->cloudGroupBox->setChecked(checked);
    ui->localGroupBox->setChecked(!checked);
    ui->cloudFileRestoreLineEdit->setEnabled(false);
    ui->cloudFileList->clear();
    updateCloudFileList();
}


//-------------------------------------------------------------------------------------------------------------------------------------------------//

//Page3信号槽函数连接信号
void Widget::Page3Connet(){    
    //删除任务槽函数连接
    connect(ui->deleteTaskButton,&QToolButton::clicked,[=]{
        DeleteTaskButton_clicked();
    });
    //清空任务槽函数连接
    connect(ui->clearTaskButton,&QToolButton::clicked,[=]{
        ClearTaskButton_clicked();
    });
    //校验任务槽函数连接
    connect(ui->checkButton,&QToolButton::clicked,[=]{
        CheckButton_clicked();
    });
}

//删除任务按钮点击事件
void Widget::DeleteTaskButton_clicked() {
    if(ui->taskList->topLevelItemCount()!=0){
        if (QMessageBox::Yes != QMessageBox::question(this, "警告", "确认删除？", QMessageBox::Yes | QMessageBox::No)) {
            return;
        }
    }
    if (ui->taskList->currentItem()) {
        taskManager->removeTask(ui->taskList->indexOfTopLevelItem(ui->taskList->currentItem()));
        delete ui->taskList->currentItem();
        if (!ui->taskList->currentItem() && ui->taskList->topLevelItemCount()) {
            ui->taskList->setCurrentItem(ui->taskList->topLevelItem(0));
        }
    }
    QMessageBox::information(this, "提示", "删除成功。",QMessageBox::Yes, QMessageBox::Yes);

}

//清空任务按钮点击事件
void Widget::ClearTaskButton_clicked() {
    if(ui->taskList->topLevelItemCount()!=0){
        if (QMessageBox::Yes != QMessageBox::question(this, "警告", "确认清空？", QMessageBox::Yes | QMessageBox::No)) {
            return;
        }
    }
    ui->taskList->clear();
    taskManager->clear();
    QMessageBox::information(this, "提示", "删除成功。",QMessageBox::Yes, QMessageBox::Yes);
}


//任务列表某一项被点击时候
void Widget::on_taskList_itemClicked(QTreeWidgetItem *item, int column)
{
    if(item->text(3)=="是"){
        ui->checkButton->setText("校验云端文件");
    }else{
        ui->checkButton->setText("校验本地文件");
    }
}

//校验按钮点击事件
void Widget::CheckButton_clicked(){
    QTreeWidgetItem *currentItem=ui->taskList->currentItem();
    if (currentItem){
        Decompressor decompressor;
        QDir dir;
        dir.mkdir("./TEMP");
        QFileInfo TEMP("./TEMP");
        int index = ui->taskList->indexOfTopLevelItem(currentItem);
        if(taskManager->getTaskList()[index].getCloud()){//是云端备份,校验云端文件
            int flag=0;//用来判断日志文件中备份到云端的文件是否存在
            for(int i=0;i<ui->cloudFileList->topLevelItemCount();i++){
                if(ui->cloudFileList->topLevelItem(i)->text(0)==currentItem->text(0)){
                    flag=1;
                    break;
                }
            }
            if(flag==0){
                QMessageBox::information(this, "提示", "无法获取文件信息，请检查该文件是否在云端备份列表是否存在！！",QMessageBox::Yes, QMessageBox::Yes);
            }
            if(flag==1){
                QNetworkAccessManager* manager = new QNetworkAccessManager(this);
                QNetworkRequest request(QUrl(api + "file/" + currentItem->text(0)));
                QNetworkReply* reply = manager->get(request);
                connect(manager, &QNetworkAccessManager::finished, this, [=](QNetworkReply * _reply) {
                    QDir dir;
                    dir.mkdir("./Cloud");
                    auto file = QByteArray::fromBase64(_reply->readAll());
                    QFile cloudFile("./Cloud/" + QFileInfo(currentItem->text(4)).fileName());
                    cloudFile.open(QFile::WriteOnly);
                    cloudFile.write(file);
                    cloudFile.close();
                    QFileInfo info("./Cloud/"+QFileInfo(currentItem->text(4)).fileName());
                    QString absoluteFilePath=info.absoluteFilePath();
                     Decompressor decompressor;
                    int errorCode = decompressor.decompress(absoluteFilePath.toStdString(),TEMP.absoluteFilePath().toStdString() + "/",
                                                            taskManager->getTaskList()[index].getPassword().toStdString());
                    if (errorCode) {
                        QStringList message = {"正常执行", "源文件扩展名不是bak", "打开源文件失败", "打开目标文件失败", "文件过短，频率表不完整", "文件结尾不完整", "密码错误", "解码错误"};
                        QMessageBox::information(this, "提示", message[errorCode],QMessageBox::Yes, QMessageBox::Yes);
                        dir.rmdir("./TEMP");
                        return;
                    }
                    QString tempFilename = "./TEMP/" + QFileInfo(currentItem->text(4)).fileName();
                    tempFilename = tempFilename.left(tempFilename.length() - 3) + "tar";
                    qDebug() << tempFilename;

                    Unpackage *unpackage=new Unpackage();
                    qDebug()<<QFileInfo(tempFilename).absoluteFilePath();
                    errorCode = unpackage->unPackage(QFileInfo(tempFilename).absoluteFilePath(), "./TEMP");

                    if (errorCode) {
                        QStringList message = {"正常执行",  "打开源文件失败", "目标文件打开失败", "创建目录失败"};
                        QMessageBox::information(this, "提示", message[errorCode],QMessageBox::Yes, QMessageBox::Yes);
                        return;
                    }
                    auto difference = Check::check(taskManager->getTaskList()[index].getFiles(), "./TEMP");
                    if (difference.empty()) {
                        QMessageBox::information(this, "提示", "备份无差异",QMessageBox::Yes, QMessageBox::Yes);
                    }else {
                        QMessageBox::information(this, "提示", "备份有差异",QMessageBox::Yes, QMessageBox::Yes);
                        QFile diff("diff.txt");
                        diff.open(QFile::WriteOnly);
                        QStringList types = {"删除", "修改", "增加"};
                        for (auto& d : difference) {
                            auto filename = d.first;
                            auto type = d.second;
                            diff.write(types[type].toStdString().c_str());
                            diff.write(" ");
                            diff.write(filename.toStdString().c_str());
                            diff.write("\n");
                        }
                        diff.close();
                        QProcess notepad;
                        notepad.startDetached("notepad diff.txt");
                    }
                    QStringList del_file;
                    del_file<<"./Cloud" << "./TEMP";
                    QStringListIterator strIterator(del_file);
                    dir.setPath(del_file[0]);
                    dir.removeRecursively();
                    dir.setPath(del_file[1]);
                    dir.removeRecursively();

                });
                connect(reply,QOverload<QNetworkReply::NetworkError>::of(&QNetworkReply::error),this,[=](QNetworkReply::NetworkError code) {
                    if (code) {
                        QMessageBox::information(this, "提示", "云备份获取失败。",QMessageBox::Yes, QMessageBox::Yes);
                        dir.rmdir("./TEMP");
                    }
                });

            }
        }else{//是本地备份，校验本地文件
            int errorCode = decompressor.decompress(currentItem->text(4).toStdString(),
                                                    TEMP.absoluteFilePath().toStdString() + "/",
                                                    taskManager->getTaskList()[index].getPassword().toStdString());
            if (errorCode) {
                QStringList message = {"正常执行", "源文件扩展名不是bak", "打开源文件失败", "打开目标文件失败", "文件过短，频率表不完整", "文件结尾不完整", "密码错误", "解码错误"};
                QMessageBox::information(this, "提示", message[errorCode],QMessageBox::Yes, QMessageBox::Yes);
                dir.rmdir("./TEMP");
                return;
            }


            QString tempFilename = "./TEMP/" + QFileInfo(currentItem->text(4)).fileName();
            tempFilename = tempFilename.left(tempFilename.length() - 3) + "tar";
            qDebug() << tempFilename;

            Unpackage *unpackage=new Unpackage();
            errorCode = unpackage->unPackage(QFileInfo(tempFilename).absoluteFilePath(), "./TEMP");
            if (errorCode) {
                QStringList message = {"正常执行",  "打开源文件失败", "目标文件打开失败", "创建目录失败"};
                QMessageBox::information(this, "提示", message[errorCode],QMessageBox::Yes, QMessageBox::Yes);
                return;
            }

            auto difference = Check::check(taskManager->getTaskList()[index].getFiles(), "./TEMP");
            if (difference.empty()) {
                QMessageBox::information(this, "提示", "备份无差异",QMessageBox::Yes, QMessageBox::Yes);
            } else {
                QMessageBox::information(this, "提示", "备份有差异",QMessageBox::Yes, QMessageBox::Yes);
                QFile diff("diff.txt");
                diff.open(QFile::WriteOnly);
                QStringList types = {"删除", "修改", "增加"};
                for (auto& d : difference) {
                    auto filename = d.first;
                    auto type = d.second;
                    diff.write(types[type].toStdString().c_str());
                    diff.write(" ");
                    diff.write(filename.toStdString().c_str());
                    diff.write("\n");
                }
                diff.close();
                QProcess notepad;
                notepad.startDetached("notepad diff.txt");
            }
            QString del_file = QString("./TEMP");
            QDir dir;
            dir.setPath(del_file);
            dir.removeRecursively();
        }

    }
}

//---------------------------------------------------------------------------------------------------------------------------------------//



