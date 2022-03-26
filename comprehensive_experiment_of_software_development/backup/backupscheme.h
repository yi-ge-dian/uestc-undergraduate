#ifndef BACKUPSCHEME_H
#define BACKUPSCHEME_H

#include <QDialog>

namespace Ui {
class BackupScheme;
}

class BackupScheme : public QDialog
{
    Q_OBJECT


public:
    explicit BackupScheme(QWidget *parent = nullptr);

    ~BackupScheme();

signals:
    void sendData(QString password,bool cloudCheckFlag,bool passwordCheckFlag);

public slots:

    void PasswordCheckBox_stateChanged();
    void GetData();


private:

    Ui::BackupScheme *ui;



};

#endif // BACKUPSCHEME_H
