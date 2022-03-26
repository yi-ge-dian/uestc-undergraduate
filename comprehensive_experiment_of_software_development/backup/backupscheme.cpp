#include "backupscheme.h"
#include "ui_backupscheme.h"
#include <QMessageBox>

BackupScheme::BackupScheme(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::BackupScheme)
{
    ui->setupUi(this);
    connect(ui->passwordCheckBox,&QCheckBox::clicked,[=]{
        PasswordCheckBox_stateChanged();
    });


    connect(ui->confirmButton,&QToolButton::clicked,[=]{
        GetData();
    });

}

BackupScheme::~BackupScheme()
{
    delete ui;
}

void  BackupScheme::PasswordCheckBox_stateChanged() {
    ui->passwordLineEdit->setEnabled(ui->passwordCheckBox->checkState());
}

void BackupScheme::GetData(){
    emit sendData(ui->passwordLineEdit->text(),ui->cloudCheckBox->checkState(),ui->passwordCheckBox->checkState());
    this->close();
}




