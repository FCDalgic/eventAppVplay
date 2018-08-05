#ifndef PROFILEMANAGER_H
#define PROFILEMANAGER_H

#include <QObject>
#include <QQmlListProperty>
#include <qtextdocument.h>


#include "userinfocontainer.h"
#include <source/data/eventcontainer.h>

#include <QtQml>

#include <source/communication/restmanager.h>

class ProfileManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString AccountID READ AccountID WRITE setAccountID NOTIFY accountIDChanged)
    Q_PROPERTY(QString Username READ Username WRITE setUsername NOTIFY usernameChanged)
    Q_PROPERTY(QString Name READ Name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString Lastname READ Lastname WRITE setLastname NOTIFY lastnameChanged)
    Q_PROPERTY(QString Job READ Job WRITE setJob NOTIFY jobChanged)
    Q_PROPERTY(QString EMail READ EMail WRITE setEMail NOTIFY eMailChanged)
    Q_PROPERTY(QString Picture READ Picture WRITE setPicture NOTIFY pictureChanged)
    Q_PROPERTY(int Age READ Age WRITE setAge NOTIFY ageChanged)
    Q_PROPERTY(bool MailConfirmed READ MailConfirmed WRITE setMailConfirmed NOTIFY mailConfirmedChanged)
    Q_PROPERTY(bool LoggedIn READ LoggedIn WRITE setLoggedIn NOTIFY loggedInChanged)
    Q_PROPERTY(QQmlListProperty<EventContainer> Favorites READ getEvents NOTIFY eventListChanged)
    Q_PROPERTY(UserStatus loginStatus READ loginStatus WRITE setLoginStatus NOTIFY loginStatusChanged)

public:
    explicit ProfileManager(QObject *parent = nullptr);

    enum UserStatus
    {
        GENERAL_NOT_LOGGED = 0,
        LOGIN_MAIL_CONFIRMATION_NEED = 1,
        LOGIN_NOT_REGISTERED = 2,
        LOGIN_LOGGED = 3,
        SIGNUP_ALREADY_EXIST = 4,
        RESET_PASSWORD_MAIL_SENT = 5,
        RESET_PASSWORD_NOT_REGISTERED = 6,
        RESET_PASSWORD_UPDATED = 7,
        RESET_PASSWORD_CODE_NOT_MATCHED = 8
    };


    Q_ENUMS(UserStatus)

    QString AccountID()         { return mInfo->AccountID;}
    QString Username()          { return mInfo->Username;}
    QString Name()              { return mInfo->Surname;}
    QString Lastname()          { return mInfo->Lastname;}
    QString Job()               { return mInfo->Job;}
    QString EMail()             { return mInfo->EMail;}
    QString Picture()           { return mInfo->Picture;}
    int  Age()                  { return mInfo->Age;}
    bool MailConfirmed()        { return mInfo->MailConfirmed;}
    bool LoggedIn()             { return mIsLoggedIn;}
    UserStatus loginStatus()    { return mUserStatus;}

    void setAccountID(QString pValue)         {  mInfo->AccountID = pValue;     emit accountIDChanged(); }
    void setUsername(QString pValue)          {  mInfo->Username = pValue;      emit usernameChanged(); }
    void setName(QString pValue)              {  mInfo->Surname = pValue;       emit nameChanged(); }
    void setLastname(QString pValue)          {  mInfo->Lastname = pValue;      emit lastnameChanged(); }
    void setJob(QString pValue)               {  mInfo->Job = pValue;           emit jobChanged(); }
    void setEMail(QString pValue)             {  mInfo->EMail = pValue;         emit eMailChanged(); }
    void setPicture(QString pValue)           {  mInfo->Picture = pValue;       emit pictureChanged(); }
    void setAge(int pValue)                   {  mInfo->Age = pValue;           emit ageChanged(); }
    void setMailConfirmed(bool pValue)        {  mInfo->MailConfirmed = pValue; emit mailConfirmedChanged(); }
    void setLoggedIn(bool pValue)             {  mIsLoggedIn = pValue;          emit loggedInChanged(); }
    void setLoginStatus(UserStatus pValue)    {  mUserStatus = pValue;          emit loginStatusChanged(); }


    QQmlListProperty<EventContainer> getEvents();


    void autoLoginOnStart();

    Q_INVOKABLE bool isEventFavourite(QString pEventID);
    Q_INVOKABLE int getUserStatusID();
    Q_INVOKABLE void logOut();
    Q_INVOKABLE QString getStoredMail();
    Q_INVOKABLE QString getStoredPass();
    Q_INVOKABLE void sendResetMail(QString pMail);
    Q_INVOKABLE QString getStoredResetMail();
    Q_INVOKABLE void updatePassword(QString pMail , QString pPassword, QString pKey);

signals:
    void accountIDChanged();
    void usernameChanged();
    void nameChanged();
    void lastnameChanged();
    void jobChanged();
    void eMailChanged();
    void pictureChanged();
    void ageChanged();
    void mailConfirmedChanged();
    void loggedInChanged();
    void eventListChanged();
    void loginStatusChanged();


public slots:

    void login(QString pMail, QString pPassword);
    void signUp(QString pMail, QString pPassword);
    void addEventData(QList<EventContainer*> pEvents);

protected slots:
    void parseMessage(QString pMessage);
private slots:
    void onMailConfirmationTimeout();
private:
    bool mIsLoggedIn;
    QList<EventContainer*> mEventList;
    UserInfoContainer *mInfo;
    QStringList mFavList;
    RESTManager *mRESTManager;
    QTextDocument mUnicodeDecoder;
    UserStatus mUserStatus;

    QString mPath;
    QString mStoredResetMail;
    QSettings mSettings;
    // Burası kullanıcının mail adresini onaylayıp onaylamadığını düzenli olarak kontrol etmek amacı ile ayrı
    // bir thread içerisinde uyarlanmıştır.
    QThread *mThread;
    QTimer *mTimer;
    QString mMail, mPass;
    void saveToRegistery();
    void resetRegistery();
    void startMailConfirmation();
    void stopMailConfirmation();
};

#endif // PROFILEMANAGER_H
