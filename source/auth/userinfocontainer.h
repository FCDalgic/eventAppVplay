#ifndef USERINFOCONTAINER_H
#define USERINFOCONTAINER_H

#include <QObject>

class UserInfoContainer : public QObject
{
    Q_OBJECT
public:
    explicit UserInfoContainer(QObject *parent = nullptr);

    QString AccountID,
            Username,
            Password,
            Surname,
            Lastname,
            Job,
            EMail,
            Picture;
    int Age;
    bool MailConfirmed;
signals:


public slots:
};

#endif // USERINFOCONTAINER_H
